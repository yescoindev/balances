class StaticController < ApplicationController

  before_filter :authenticate_user!, only: [:import_instructions]

  def root
    if user_signed_in?
      redirect_to addresses_path
    else
      render :landing, layout: 'landing'
    end
  end

  def home
    render :landing, layout: 'landing'
  end

  def teaser
    render :teaser, layout: false
  end

end
