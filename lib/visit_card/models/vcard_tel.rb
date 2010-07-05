module VisitCard
  module Models
    module VcardTel
      extend ActiveSupport::Concern

      TYPES = %w{home msg work pref voice fax cell video pager bbs modem car isdn pcs}

      included do
        belongs_to :vcard
        before_validation :parse_phone
        bitmask :types, :as => TYPES
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
