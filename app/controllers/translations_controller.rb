class TranslationsController < ApplicationController
	def edit
		@offer = current_user.offers.find(params[:offer_id])
	end

	def update
		@offer = current_user.offers.find(params[:offer_id])
    if @offer.update_attributes(params[:offer])
      rener :edit, :notice  => "Successfully updated offer."
    else
      render :edit
    end
	end
end
