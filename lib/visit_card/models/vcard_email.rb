module VisitCard
  module Models
    module VcardEmail
      extend ActiveSupport::Concern

      included do
        belongs_to :vcard
        validates_format_of :value, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true, :allow_nil => true
        bitmask :types, :as => VisitCard.email_types
      end

      module InstanceMethods
      end

      module ClassMethods
      end
    end
  end
end
