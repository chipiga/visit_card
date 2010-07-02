module VisitCard
  module Models
    module Vcard
      extend ActiveSupport::Concern

      VCARD_KLASSES = %w{public private confidential}
      VCARD_NESTED_ATTRIBUTES_REJECT_IF = lambda {|a| a.reject{|k,v| k.include?('types') || k.include?('_id')}.all? {|_, v| v.blank?}}

      included do
        has_many :vcard_adrs, :dependent => :destroy
        has_many :vcard_emails, :dependent => :destroy
        has_many :vcard_tels, :dependent => :destroy
        has_many :vcard_categorizations, :dependent => :destroy
        has_many :vcard_categories, :class_name => 'VcardDictionary', :through => :vcard_categorizations
        has_many :vcard_extensions, :dependent => :destroy
        belongs_to :agent, :class_name => 'Vcard', :foreign_key => 'agent_id'

        validates :family_name, :given_name, :presence => true
        validates_numericality_of :latitude, :longitude, :allow_nil => true
        validates_format_of :photo, :logo, :url, :with => URI::regexp(%w{http https}), :allow_blank => true, :allow_nil => true

        # Setup accessible (or protected) attributes for your model
        # attr_accessible :given_name, :last_name, :additional_name

        scope :except, lambda {|id| id.blank? ? where('1 = 1') : where('id <> ?', (::Vcard.find(id).id rescue 0))} # for slugs support
        # scope :excepts, lambda {|*ids| ids.compact.blank? ? where('1 = 1') : where('id NOT IN(?)', ids.join(','))}

        accepts_nested_attributes_for :vcard_adrs, :vcard_tels, :vcard_emails, :vcard_extensions,
                                      :reject_if => VCARD_NESTED_ATTRIBUTES_REJECT_IF, :allow_destroy => true
      end

      module InstanceMethods
        def fn
          "#{honorific_prefix} #{given_name} #{additional_name ? additional_name << ' ': ''}#{family_name} #{honorific_suffix}".strip
        end

        def n
          "#{family_name};#{given_name};#{additional_name};#{honorific_prefix};#{honorific_suffix}"
        end

        def fga
          "#{family_name} #{given_name} #{additional_name}".strip
        end

        # TODO move to separate builder class
        def to_hcard
          out = ''
          out << (url? ? "<a href='#{url}' class='fn url'>#{fn}</a>" : "<span class='fn'>#{fn}</span>")
          out.html_safe
        end
      end

      module ClassMethods
      end
    end
  end
end
