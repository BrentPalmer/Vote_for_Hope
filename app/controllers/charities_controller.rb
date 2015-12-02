class CharitiesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin?, except: [:index, :show, :vote]
  before_action :set_charity, only: [:show, :edit, :update, :destroy, :vote]

  def index
    @charities = Charity.all
  end

  def show
  end

  def new
    @charity = Charity.new
  end

  def create
    @charity = Charity.new(charity_params)

    if @charity.save
      flash[:notice] = "Charity successfully created!"
      redirect_to charities_path
    else
      flash[:notice] = "Something went wrong"
      redirect_to :back
    end

  end

  def edit
  end

  def update
    if @charity.update(charity_params)
      flash[:noice] = "Charity has been updated"
      redirect_to charities_path
    else
      flash[:notie] = "Something went wrong"
      redirect_to :back
    end
  end

  def destroy
    if @charity.destroy
      flash[:notice] = "Charity has been deleted!"
      redirect_to charities_path
    end
  end

  def vote
    @vote = Vote.create(voteable: @charity, vote: params[:vote], user_id: params[:user_id])

    if @vote.valid?
      flash[:notice] = "Vote was counted!"
      redirect_to charities_path
    else
      flash[:notice] = "you can only vote once"
      redirect_to :back
    end
  end


private
  
  def charity_params
    params.require(:charity).permit(:name, :description, :mission_statement, :avatar, :background_image, :url, :created_at, :updated_at, :vote)
  end

  def set_charity
    @charity = Charity.find_by(id: params[:id])
  end
end