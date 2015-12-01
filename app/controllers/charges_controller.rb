class ChargesController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def create

    Stripe::Customer.create(
      :source => params[:stripeToken],
      :plan => "gold",
      :email => "#{current_user.email}"
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end
  
end
