class ChargesController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def create

    customer = Stripe::Customer.create(
      :source => params[:stripeToken],
      :plan => "gold",
      :email => "#{current_user.email}"
    )

    update_customer_id_and_subscription_id(customer)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end
  
  def destroy
    customer = Stripe::Customer.retrieve(current_user.customer_id)
    customer.subscriptions.retrieve(current_user.subscription_id).delete(:at_period_end => true)
  end

private
  def update_customer_id_and_subscription_id(customer)
    stripe_customer_params = JSON.parse(customer.to_s)

    current_user.update_attribute(:customer_id, stripe_customer_params["id"])
    current_user.update_attribute(:subscription_id, stripe_customer_params["subscriptions"]["data"][0]["id"])
    current_user.save
  end
end
