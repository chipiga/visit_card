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
        def to_hcard(options = {})
          result = []
          result << "<span class='type'>#{types.join(', ').titleize}</span>" unless types.empty?
          tag_name = options.fetch(:tag_name, 'a')
          result << "<#{tag_name} class='value' href='mailto:#{value}'>#{value}</#{tag_name}>"
          main_tag_name = options.fetch(:main_tag_name, 'div')
          ("<#{main_tag_name} class='email'>" << result.join(' ') << "</#{main_tag_name}>").html_safe
        end
      end

      module ClassMethods
      end
    end
  end
end
