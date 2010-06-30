module VisitCard
  VCARD_VERSION = '3.0'

  module Models
    autoload :Vcard, 'visit_card/models/vcard'
    autoload :VcardAdr, 'visit_card/models/vcard_adr'
    autoload :VcardCategorization, 'visit_card/models/vcard_categorization'
    autoload :VcardDictionary, 'visit_card/models/vcard_dictionary'
    autoload :VcardEmail, 'visit_card/models/vcard_email'
    autoload :VcardExtention, 'visit_card/models/vcard_extention'
    autoload :VcardTel, 'visit_card/models/vcard_tel'
  end

  module Controllers
    autoload :VcardsController, 'visit_card/controllers/vcards_controller'
  end

  module Helpers
    autoload :VcardsHelper, 'visit_card/helpers/vcards_helper'
  end

  class Engine < Rails::Engine
    paths.app.views = 'app/views/visit_card'
  end
end
