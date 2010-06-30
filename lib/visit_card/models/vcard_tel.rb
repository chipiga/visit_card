module VisitCard
  module Models
    module VcardTel
      extend ActiveSupport::Concern

      TYPES = %w{home msg work pref voice fax cell video pager bbs modem car isdn pcs}

      included do
        belongs_to :vcard
        # TODO phone format parse and validate
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
