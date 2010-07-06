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
        def to_hcard(options = {})
          result = []
          result << "<span class='type'>#{types.join(', ').titleize}</span>" unless types.empty?
          tag_name = options.fetch(:tag_name, 'span')
          result << "<#{tag_name} class='value'>#{value}</#{tag_name}>"
          main_tag_name = options.fetch(:main_tag_name, 'div')
          ("<#{main_tag_name} class='tel'>" << result.join(' ') << "</#{main_tag_name}>").html_safe
        end

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
