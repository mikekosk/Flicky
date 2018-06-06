class SummaryController < ApplicationController

  def index
    @user = User.find(params[:id])
    @ratings =
    @movies = @user.movies
  end

end
