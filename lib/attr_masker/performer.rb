# (c) 2017 Ribose Inc.
#
module AttrMasker
  module Performer
    class ActiveRecord
      def mask
        unless defined? ::ActiveRecord
          warn "ActiveRecord undefined. Nothing to do!"
          exit 1
        end

        # Do not want production environment to be masked!
        #
        if Rails.env.production?
          Rails.logger.warn "Why are you masking me?! :("
          exit 1
        end

        ::ActiveRecord::Base.descendants.each do |klass|
          if klass.table_exists?
            printf "Masking #{klass}... "

            if klass.count < 1 || klass.masker_attributes.length < 1
              puts "Nothing to do!"
            else

              klass.all.each do |model|
                mask_object model
              end

              puts " ==> done!"
            end
          end
        end
        puts "All done!"
      end

      private

      # For each masker attribute, mask it, and save it!
      #
      def mask_object(instance)
        printf "\n --> masking #{instance.id} - #{instance}... "

        return if instance.class.masker_attributes.empty?

        updates = instance.class.masker_attributes.reduce({}) do |acc, masker_attr|
          attr_name = masker_attr[0]
          column_name = masker_attr[1][:column_name] || attr_name
          masker_value = instance.mask(attr_name)
          acc.merge!(column_name => masker_value)
        end

        instance.class.all.update(instance.id, updates)

        printf "OK"
      end
    end
  end
end
