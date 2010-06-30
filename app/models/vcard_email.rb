class VcardEmail < ActiveRecord::Base
  belongs_to :vcard

  validates_format_of :value, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true, :allow_nil => true

  TYPES = %w{internet x400 pref}

  def types=(types)
    self.types_mask = (types & TYPES).map { |r| 2**TYPES.index(r) }.sum
  end

  def types
    TYPES.reject do |r|
      ((types_mask || 0) & 2**TYPES.index(r)).zero?
    end
  end
end
