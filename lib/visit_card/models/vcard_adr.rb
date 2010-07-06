module VisitCard
  module Models
    module VcardAdr
      extend ActiveSupport::Concern

      included do
        belongs_to :vcard
        bitmask :types, :as => VisitCard.adr_types
        SERIALZABLE_ATTRIBUTES = %w{post_office_box extended_address street_address locality region postal_code country_name}
      end

      module InstanceMethods
        def adr
          # "#{post_office_box};#{extended_address};#{street_address};#{locality};#{region};#{postal_code};#{country_name}"
          SERIALZABLE_ATTRIBUTES.join(';')
        end
        
        def to_hcard(options = {})
          result = []
          result << "<span class='type'>#{types.join(', ').titleize}</span>" unless types.empty?
          tag_name = options.fetch(:tag_name, 'span')
          SERIALZABLE_ATTRIBUTES.each do |attr_name|
            result << wrap_attribute(attr_name, tag_name)
          end
          result.compact!
          main_tag_name = options.fetch(:main_tag_name, 'div')
          ("<#{main_tag_name} class='adr'>" << result.join(' ') << "</#{main_tag_name}>").html_safe
        end

        private

        def wrap_attribute(attr_name, tag_name = 'span')
          value = send(attr_name.to_sym)
          value.present? ? "<#{tag_name} class='#{attr_name.gsub('_','-')}'>#{value}</#{tag_name}>" : nil
        end
      end

      module ClassMethods
      end
    end
  end
end
