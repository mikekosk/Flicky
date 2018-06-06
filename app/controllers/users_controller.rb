class UsersController < ApplicationController

  def show
    ## Load Movie from ID
    @user = User.find(params[:id])
    movie_id = params[:movie_id].to_i
    @movie = @user.movies[movie_id]

    ## Process ratings
    if params[:user_action]
      action = params[:user_action]
      viewer = params[:viewer_id]

      ## Create Ratings Table Entry
      if action == "up"
        @user.ratings.create(:movie=>movie_id,:star=>true,:score=>2, :viewer=>viewer)
      elsif action == "down"
        @user.ratings.create(:movie=>movie_id,:score=>0, :viewer=>viewer)
      elsif action == "right"
        @user.ratings.create(:movie=>movie_id,:score=>1, :viewer=>viewer)
      elsif action == "left"
        @user.ratings.create(:movie=>movie_id,:score=>-1, :viewer=>viewer)
      end

      ## Go to next movie
      if movie_id == 19
        if viewer == session[:viewers]
          redirect_to params.permit(:id, :action).merge({:id => params[:id], action: 'summary'})
          return
        else
          redirect_to params.permit(:movie_id, :viewer_id)
                .merge({:movie_id => 1, :viewer_id => viewer.to_i+1})
          return
        end
      end

      ## Show Next Movie
      next_movie = movie_id+1
      redirect_to params.permit(:movie_id, :viewer_id)
            .merge({:movie_id => next_movie})
    end

  end

  def summary
    user = User.find(params[:id])
    @movies = user.movies
    @ratings = Rating.where(user_id: user.id).group(:movie).sum(:score).sort_by { |x| x[1] }.reverse
  end

end
