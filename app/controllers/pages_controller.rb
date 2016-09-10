class PagesController < ApplicationController
  def show
    @get_started_link = new_user_session_path
    @logo_link = root_path

    render template: "pages/#{params[:page]}"
  end
end
