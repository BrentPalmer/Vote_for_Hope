class CharitiesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin?, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @charities = Charity.all
  end

  def show
  end

  def new
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
  end

  def destroy
    if @charity.destroy
      flash[:notice] = "Charity has been deleted!"
      redirect_to charities_path
    end
  end


private
  
  def charity_params
    params.require(:charities).permit(:name, :description, :mission_statement, :avatar, :background_image, :url, :created_at, :updated_at)
  end

  def set_charity
    @charity = Charity.find_by(params[:id])
  end
end