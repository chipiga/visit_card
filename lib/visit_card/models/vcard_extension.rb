module VisitCard
  module Models
    module VcardExtension
      extend ActiveSupport::Concern

      included do
        belongs_to :vcard
        belongs_to :vcard_extension_type, :class_name => 'VcardDictionary'
        validates :vcard_extension_type, :presence => true
        bitmask :types, :as => VisitCard.extension_types
      end

      module InstanceMethods
      end

      module ClassMethods
      end
    end
  end
end
