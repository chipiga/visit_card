module VisitCard
  module Models
    module VcardTel
      extend ActiveSupport::Concern

      TYPES = %w{home msg work pref voice fax cell video pager bbs modem car isdn pcs}

      included do
        belongs_to :vcard
        # TODO phone format parse and validate
        bitmask :types, :as => TYPES
      end

      module InstanceMethods
      end

      module ClassMethods
      end
    end
  end
end
