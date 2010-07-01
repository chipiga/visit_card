module VisitCard
  module Controllers
    module VcardsController
      extend ActiveSupport::Concern

      included do
        respond_to :html
      end

      module InstanceMethods
        def index
          @vcards ||= Vcard.all
          respond_with(@vcards)
        end

        def show
          @vcard ||= Vcard.find(params[:id])
          respond_with(@vcards)
        end

        def new
          @vcard ||= Vcard.new
          build_relations
          respond_with(@vcard)
        end

        def edit
          @vcard ||= Vcard.find(params[:id])
          build_relations
          respond_with(@vcard)
        end

        def create
          @vcard ||= Vcard.new(params[:vcard])
          build_relations unless @vcard.save
          respond_with(@vcard)
        end

        def update
          @vcard ||= Vcard.find(params[:id])
          build_relations unless @vcard.update_attributes(params[:vcard])
          respond_with(@vcard)
        end

        def destroy
          @vcard ||= Vcard.find(params[:id])
          @vcard.destroy
          respond_with(@vcard)
        end

        private

        def build_relations
          @vcard.vcard_adrs.build if @vcard.vcard_adrs.empty?
          @vcard.vcard_tels.build if @vcard.vcard_tels.empty?
          @vcard.vcard_emails.build if @vcard.vcard_emails.empty?
          @vcard.vcard_extentions.build if @vcard.vcard_extentions.empty?
        end
      end

      module ClassMethods
      end
    end
  end
end
