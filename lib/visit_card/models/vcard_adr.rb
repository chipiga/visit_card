module VisitCard
  module Models
    module VcardAdr
      extend ActiveSupport::Concern

      included do
        belongs_to :vcard
        bitmask :types, :as => VisitCard.adr_types
      end

      module InstanceMethods
      end

      module ClassMethods
      end
    end
  end
end
