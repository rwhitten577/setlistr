class SetlistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @setlists = current_user.setlists
  end

  def show
    @setlist = Setlist.find(params[:id])
    @band = @setlist.band
  end

  def new
    @setlist = Setlist.new
    @submit = 'Create Setlist'
    @action = 'New'
  end

  def create
    @setlist = Setlist.new(setlist_params)
    @band = Band.find(params[:setlist][:band])
    @setlist.band = @band
    if @setlist.save
      flash[:notice] = 'Setlist successfully created!'
      redirect_to @setlist
    else
      flash[:notice] = 'There were problems saving your setlist.'
      @venue_error = "Venue or name can't be blank."
      render :new
    end
  end

  def edit
    @setlist = Setlist.find(params[:id])
    @submit = 'Save'
    @action = 'Edit'
  end

  def update
    @setlist = Setlist.find(params[:id])
    @band = Band.find(params[:setlist][:band])
    if @setlist.update_attributes(setlist_params)
      if @setlist.band != @band
        @setlist.band = @band
      end
      flash[:notice] = 'Setlist successfully saved!'
      redirect_to @setlist
    else
      flash[:notice] = 'There were problems saving your setlist.'
      @venue_error = "Venue or name can't be blank."
      render :edit
    end
  end

  def destroy
    setlist = Setlist.find(params[:id])
    setlist.destroy
    flash[:notice] = 'Setlist deleted.'
    redirect_to setlists_path
  end

  private

  def setlist_params
    params.require(:setlist).permit(:venue, :date)
  end
end
