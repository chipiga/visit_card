module VisitCard
  module Models
    module VcardAdr
      extend ActiveSupport::Concern

      TYPES = %w{dom intl postal parcel home work pref}

      included do
        belongs_to :vcard
      end

      module InstanceMethods
        def types=(types)
          self.types_mask = (types & TYPES).map { |r| 2**TYPES.index(r) }.sum
        end

        def types
          TYPES.reject do |r|
            ((types_mask || 0) & 2**TYPES.index(r)).zero?
          end
        end
      end

      module ClassMethods
      end
    end
  end
end
