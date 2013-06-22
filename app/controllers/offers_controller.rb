class OffersController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  load_and_authorize_resource

  def index
    @offers = current_user.offers.all
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def new
    @offer = Offer.new
    @offer.photos.build
  end

  def create
    @offer = current_user.offers.new(params[:offer])
    @offer.translations.build(params[:id])
    if @offer.save
      redirect_to edit_offer_details_path(@offer), :notice => "Successfully created offer, now fill in other details."
      
    else
      render :new
    end
  end

=begin
 def edit
    @offer = current_user.offers.find(params[:id])
    @offer.photos.build
  end
=end

  def update
    @offer = current_user.offers.find(params[:id])
    if @offer.update_attributes(params[:offer])
      redirect_to :back, :notice  => "Successfully updated offer, fill in other information if missed."
    else
      render :edit
    end
  end

  def destroy
    @offer = current_user.offers.find(params[:id])
    @offer.destroy
    redirect_to offers_url, :notice => "Successfully destroyed offer."
  end

end
