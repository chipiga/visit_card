class VcardDictionary < ActiveRecord::Base
  KLASSES = %w{category extention_type}

  validates :klass, :name, :presence => true
  validates_uniqueness_of :name, :scope => :klass

  scope :ordered, order('name ASC')
  scope :categories, where(:klass => 'category')
  scope :extention_types, where(:klass => 'extention_type')
  default_scope ordered
end
