module VisitCard
  module Models
    module VcardTel
      extend ActiveSupport::Concern

      included do
        belongs_to :vcard
        before_validation :parse_phone
        bitmask :types, :as => VisitCard.tel_types
      end

      module InstanceMethods
        protected

        def parse_phone
          self.value = Phone.parse(value).to_s if defined? Phone
        end
      end

      module ClassMethods
      end
    end
  end
end
