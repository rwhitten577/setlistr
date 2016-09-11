class BandsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bands = current_user.bands
  end
end
