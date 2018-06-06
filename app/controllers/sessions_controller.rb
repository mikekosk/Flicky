class SessionsController < ApplicationController

  def create
    # Generate random user ID
    #user_id = SecureRandom.hex(5)

    # Select random movies
    category = rand(0..4)
  	page = rand(1..5)

  	if category == 0
  		list = Tmdb::Discover.movie(page: page)
  	elsif category == 1
  		list = Tmdb::Movie.upcoming(page: page)
  	elsif category == 2
  		list = Tmdb::Movie.now_playing(page: page)
  	elsif category == 3
  		list = Tmdb::Movie.popular(page: page)
  	elsif category == 4
  		list = Tmdb::Movie.top_rated(page: page)
  	end


    # Load movies into db
    user = User.new(movies: list["results"])
    user.save

    # Temporarily use user_id before I figure out why passing nulls
    #user = User.find(1)

    # Save the number of viewers
    session[:viewers] = params[:session][:viewers]

    # Redirect to first viewer, u
    redirect_to user_path(:id => user_id, :movie_id => 1, :viewer_id => 1)
  end

end
