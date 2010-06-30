module VisitCard
  module Models
    module VcardDictionary
      extend ActiveSupport::Concern

      KLASSES = %w{category extention_type}

      included do
        validates :klass, :name, :presence => true
        validates_uniqueness_of :name, :scope => :klass

        scope :ordered, order('name ASC')
        scope :categories, where(:klass => 'category')
        scope :extention_types, where(:klass => 'extention_type')
        default_scope ordered
      end

      module InstanceMethods
      end

      module ClassMethods
      end
    end
  end
end
