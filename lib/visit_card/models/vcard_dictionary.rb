module VisitCard
  module Models
    module VcardDictionary
      extend ActiveSupport::Concern

      included do
        validates :klass, :name, :presence => true
        validates_uniqueness_of :name, :scope => :klass

        scope :ordered, order('name ASC')
        scope :categories, where(:klass => 'category')
        scope :extension_types, where(:klass => 'extension_type')
        default_scope ordered
      end

      module InstanceMethods
      end

      module ClassMethods
      end
    end
  end
end
