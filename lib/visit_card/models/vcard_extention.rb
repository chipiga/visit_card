module VisitCard
  module Models
    module VcardExtention
      extend ActiveSupport::Concern

      TYPES = %w{home msg work pref voice video pager pcs internet other}

      included do
        belongs_to :vcard
        belongs_to :vcard_extention_type, :class_name => 'VcardDictionary'
        validates :vcard_extention_type, :presence => true
        bitmask :types, :as => TYPES
      end

      module InstanceMethods
      end

      module ClassMethods
      end
    end
  end
end
