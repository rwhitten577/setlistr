class BandsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bands = current_user.bands
  end

  def show
    @band = Band.find(params[:id])
    @members = @band.users
  end
end
