require 'bitmask-attribute'

module VisitCard
  VCARD_VERSION = '3.0'

  mattr_accessor :klasses
  @@klasses = %w{public private confidential}

  mattr_accessor :adr_types
  @@adr_types = %w{dom intl postal parcel home work pref}

  mattr_accessor :email_types
  @@email_types = %w{internet x400 pref}

  mattr_accessor :extension_types
  @@extension_types = %w{home msg work pref voice video pager pcs internet other}

  mattr_accessor :tel_types
  @@tel_types = %w{home msg work pref voice fax cell video pager bbs modem car isdn pcs}

  module Models
    extend ActiveSupport::Autoload

    autoload :Vcard
    autoload :VcardAdr
    autoload :VcardCategorization
    autoload :VcardDictionary
    autoload :VcardEmail
    autoload :VcardExtension
    autoload :VcardTel
  end

  module Controllers
    extend ActiveSupport::Autoload

    autoload :VcardsController
  end

  module Helpers
    extend ActiveSupport::Autoload

    autoload :VcardsHelper
  end

  class Engine < Rails::Engine
    paths.app.views = 'app/views/visit_card'
  end
end
