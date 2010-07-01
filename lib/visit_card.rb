require 'bitmask-attribute'

module VisitCard
  VCARD_VERSION = '3.0'

  module Models
    extend ActiveSupport::Autoload

    autoload :Vcard
    autoload :VcardAdr
    autoload :VcardCategorization
    autoload :VcardDictionary
    autoload :VcardEmail
    autoload :VcardExtention
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
