module VisitCard
  module Models
    module VcardAdr
      extend ActiveSupport::Concern

      TYPES = %w{dom intl postal parcel home work pref}

      included do
        belongs_to :vcard
        bitmask :types, :as => TYPES
      end

      module InstanceMethods
      end

      module ClassMethods
      end
    end
  end
end
