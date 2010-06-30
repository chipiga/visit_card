class VcardCategorization < ActiveRecord::Base
  belongs_to :vcard
  belongs_to :vcard_category, :class_name => 'VcardDictionary', :foreign_key => :vcard_dictionary_id
end
