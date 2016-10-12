class HomeController < ApplicationController
  skip_before_filter :authenticate_session


  def index
  end

end
