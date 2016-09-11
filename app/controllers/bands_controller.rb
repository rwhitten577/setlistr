class BandsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bands = current_user.bands
  end

  def show
    @band = Band.find(params[:id])
    @members = @band.users
  end

  def new
    @band = Band.new
    @submit = 'Create Band'
    @action = 'New'
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      Member.create(band: @band, user: current_user)
      flash[:notice] = 'Band successfully created!'
      redirect_to @band
    else
      flash[:notice] = 'There were problems saving your band.'
      @name_error = "Name can't be blank."
      render :new
    end
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
