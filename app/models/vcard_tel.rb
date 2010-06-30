class VcardTel < ActiveRecord::Base
  belongs_to :vcard

  # TODO phone format parse

  TYPES = %w{home msg work pref voice fax cell video pager bbs modem car isdn pcs}

  def types=(types)
    self.types_mask = (types & TYPES).map { |r| 2**TYPES.index(r) }.sum
  end

  def types
    TYPES.reject do |r|
      ((types_mask || 0) & 2**TYPES.index(r)).zero?
    end
  end
end
