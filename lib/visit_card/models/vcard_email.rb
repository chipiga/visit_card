module VisitCard
  module Models
    module VcardEmail
      extend ActiveSupport::Concern

      TYPES = %w{internet x400 pref}

      included do
        belongs_to :vcard
        validates_format_of :value, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true, :allow_nil => true
        # bitmask :types_mask, :as => TYPES
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
