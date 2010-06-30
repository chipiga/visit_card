module VisitCard
  module Models
    module VcardCategorization
      extend ActiveSupport::Concern

      included do
        belongs_to :vcard
        belongs_to :vcard_category, :class_name => 'VcardDictionary', :foreign_key => :vcard_dictionary_id
      end

      module InstanceMethods
      end

      module ClassMethods
      end
    end
  end
end
