module VisitCard
  module Models
    module Vcard
      extend ActiveSupport::Concern

      VCARD_NESTED_ATTRIBUTES_REJECT_IF = lambda {|a| a.reject{|k,v| k.include?('types') || k.include?('_id')}.all? {|_, v| v.blank?}}

      included do
        has_many :vcard_adrs, :dependent => :destroy
        has_many :vcard_emails, :dependent => :destroy
        has_many :vcard_tels, :dependent => :destroy
        has_many :vcard_categorizations, :dependent => :destroy
        has_many :vcard_categories, :class_name => 'VcardDictionary', :through => :vcard_categorizations
        has_many :vcard_extensions, :dependent => :destroy
        belongs_to :agent, :class_name => 'Vcard', :foreign_key => 'agent_id'

        validate :validates_fn # validates :family_name, :given_name, :presence => true
        validates_numericality_of :latitude, :longitude, :allow_nil => true
        validates_format_of :photo, :logo, :url, :with => URI::regexp(%w{http https}), :allow_blank => true, :allow_nil => true

        # Setup accessible (or protected) attributes for your model
        # attr_accessible :given_name, :last_name, :additional_name

        scope :except, lambda {|id| id.blank? ? where('1 = 1') : where('id <> ?', (::Vcard.find(id).id rescue 0))} # for slugs support
        # scope :excepts, lambda {|*ids| ids.compact.blank? ? where('1 = 1') : where('id NOT IN(?)', ids.join(','))}
        scope :sort_string_asc, order('sort_string ASC')

        accepts_nested_attributes_for :vcard_adrs, :vcard_tels, :vcard_emails, :vcard_extensions,
                                      :reject_if => VCARD_NESTED_ATTRIBUTES_REJECT_IF, :allow_destroy => true
      end

      module InstanceMethods
        def fn
          fn = "#{honorific_prefix} #{given_name} #{additional_name} #{family_name} #{honorific_suffix}".squeeze(' ').strip
          fn ? fn : org
        end

        def n
          "#{family_name};#{given_name};#{additional_name};#{honorific_prefix};#{honorific_suffix}"
        end

        def fga
          "#{family_name} #{given_name} #{additional_name}".strip
        end

        def geo
          result = "#{latitude};#{longitude}"
          result == ';' ? '' : result
        end

        def label
          "#{fn}\n#{vcard_adrs.first.adr.squeeze(';').gsub(';','\n')}".strip
        end

        def org
          organization_unit? ? "#{organization_name};#{organization_unit}" : organization_name
        end

        # TODO support two variants of category store - through habtm & simple string
        # def category
        # end

        def rev
          updated_at
        end

        # TODO refactor! template?
        # TODO separate and improve geo, org
        # TODO add photo, logo, tz, category, extensions
        def to_hcard(options = {}, &block)
          result = []
          clasess = ['fn']
          clasess << 'org' if org == fn
          if url?
            clasess << 'url'
            result << "<a class='#{clasess.join(' ')}' href='#{url}'>#{fn}</a>"
          else
            result << "<span class='#{clasess.join(' ')}'>#{fn}</span>"
          end
          result << "(<span class='nickname'>#{nickname}</span>)" if nickname?
          result << "<abbr class='bday' title='#{bday.to_s}'>#{I18n.l(bday, :format => :long)}</abbr>" if bday?
          result << "<span class='title'>#{title}</span>" if title?
          result << "<span class='role'>#{role}</span>" if role?
          result << "<span class='org'>#{org}</span>" if org.present? && org != fn
          vcard_adrs.each do |adr|
            result << adr.to_hcard
          end
          result << "<abbr class='geo' title='#{geo}'>Location</abbr>" if geo.present?
          # result << "<span class='geo'><abbr class='latitude' title='#{latitude}'>N 48° 81.6667</abbr><abbr class='longitude' title='2.366667'>E 2° 36.6667</abbr></span>" if geo.present?
          vcard_tels.each do |tel|
            result << tel.to_hcard
          end
          vcard_emails.each do |email|
            result << email.to_hcard
          end
          # result.compact!
          result << agent.to_hcard if agent_id? # TODO add agent class?
          main_tag_name = options.fetch(:main_tag_name, 'div')
          ("<#{main_tag_name} class='vcard'>" << result.join(' ') << "</#{main_tag_name}>").html_safe          
        end

        # TODO proxy to parser
        def from_hcard()
        end

        # TODO
        def to_vcard
        end

        # TODO
        def from_vcard()
        end

        protected

        def validates_fn
          if family_name.blank? && given_name.blank? && additional_name.blank? && honorific_prefix.blank? && honorific_suffix.blank?
            errors.add(:organization_name) unless organization_name?
          else
            errors.add(:family_name) unless family_name?
            errors.add(:given_name) unless given_name?
            errors.add(:organization_name) if organization_unit?
          end
        end
      end

      module ClassMethods
      end
    end
  end
end
# class String
#   def wrap_html(tag_name = 'span', options = {})
#     options[:class] ||= self
#     options.each{}
#     "<#{tag_name}>#{self}</#{tag_name}>"
#   end
# end
