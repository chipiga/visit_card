# TODO authentication & authorization, user_id & primary assign
class VcardsController < ApplicationController
  respond_to :html, :xml

  # GET /vcards
  # GET /vcards.xml
  def index
    @vcards = Vcard.all
    respond_with(@vcards)
  end

  # GET /vcards/1
  # GET /vcards/1.xml
  def show
    @vcard = Vcard.find(params[:id])
    respond_with(@vcards)
  end

  # GET /vcards/new
  # GET /vcards/new.xml
  def new
    @vcard = Vcard.new
    build_relations
    respond_with(@vcard)
  end

  # GET /vcards/1/edit
  # GET /vcards/1/edit.xml
  def edit
    @vcard = Vcard.find(params[:id])
    build_relations
    respond_with(@vcard)
  end

  # POST /vcards
  # POST /vcards.xml
  def create
    @vcard = Vcard.new(params[:vcard])
    build_relations unless @vcard.save
    respond_with(@vcard)
  end

  # PUT /vcards/1
  # PUT /vcards/1.xml
  def update
    @vcard = Vcard.find(params[:id])
    build_relations unless @vcard.update_attributes(params[:vcard])
    respond_with(@vcard)
  end

  # DELETE /vcards/1
  # DELETE /vcards/1.xml
  def destroy
    @vcard = Vcard.find(params[:id])
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
