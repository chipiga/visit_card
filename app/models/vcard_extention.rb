class VcardExtention < ActiveRecord::Base
  belongs_to :vcard
  belongs_to :vcard_extention_type, :class_name => 'VcardDictionary'

  TYPES = %w{home msg work pref voice video pager pcs internet other}

  def types=(types)
    self.types_mask = (types & TYPES).map { |r| 2**TYPES.index(r) }.sum
  end

  def types
    TYPES.reject do |r|
      ((types_mask || 0) & 2**TYPES.index(r)).zero?
    end
  end
end
