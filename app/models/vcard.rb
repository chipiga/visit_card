class Vcard < ActiveRecord::Base
  # belongs_to :user
  VERSION = '3.0'
  KLASSES = %w{public private confidential}
  NESTED_ATTRIBUTES_REJECT_IF = lambda {|a| a.reject{|k,v| k.include?('types')}.all? {|_, v| v.blank?}}

  has_many :vcard_adrs, :dependent => :destroy
  has_many :vcard_emails, :dependent => :destroy
  has_many :vcard_tels, :dependent => :destroy
  has_many :vcard_categorizations, :dependent => :destroy
  has_many :vcard_categories, :class_name => 'VcardDictionary', :through => :vcard_categorizations
  has_many :vcard_extentions, :dependent => :destroy
  belongs_to :agent, :class_name => 'Vcard', :foreign_key => 'agent_id'

  validates :family_name, :given_name, :presence => true
  validates_numericality_of :latitude, :longitude, :allow_nil => true
  validates_format_of :photo, :logo, :url, :with => URI::regexp(%w{http https}), :allow_blank => true, :allow_nil => true

  # TODO Setup accessible (or protected) attributes for your model
  # attr_accessible :given_name, :last_name, :additional_name

  scope :except, lambda {|*ids| ids.compact.blank? ? where('1 = 1') : where('id NOT IN(?)', ids.join(','))}

  accepts_nested_attributes_for :vcard_adrs, :vcard_tels, :vcard_emails, :vcard_extentions,
                                :reject_if => NESTED_ATTRIBUTES_REJECT_IF, :allow_destroy => true

  def fn
    "#{honorific_prefix} #{given_name} #{additional_name ? additional_name << ' ': ''}#{family_name} #{honorific_suffix}".strip
  end

  def n
    "#{family_name};#{given_name};#{additional_name};#{honorific_prefix};#{honorific_suffix}"
  end

  # TODO move to separate builder class
  def to_hcard
    out = ''
    out << (url? ? "<a href='#{url}' class='fn url'>#{fn}</a>" : "<span class='fn'>#{fn}</span>")
    out.html_safe
  end
end
