class VcardAdr < ActiveRecord::Base
  belongs_to :vcard

  TYPES = %w{dom intl postal parcel home work pref}

  def types=(types)
    self.types_mask = (types & TYPES).map { |r| 2**TYPES.index(r) }.sum
  end

  def types
    TYPES.reject do |r|
      ((types_mask || 0) & 2**TYPES.index(r)).zero?
    end
  end
end
