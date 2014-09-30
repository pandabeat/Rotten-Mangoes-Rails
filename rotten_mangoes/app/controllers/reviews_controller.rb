class ReviewsController < ApplicationController
 
  before_filter :load_movie, :restrict_access
  # => Load the parent resource so we don't have to 
  #    keep typing '@movie = Movie.find(params[:movie_id])' 

  def new
    # @movie = Movie.find(params[:movie_id])
    # => don't need the above line any more becaue of before_filter (protect method)
    @review = @movie.reviews.build
    # => same as @review = Review.new(movie_id: @movie.id)
  end

  def create
    # @movie = Movie.find(params[:movie_id]) 
    # => don't need the above line any more becaue of before_filter (protect method)
    @review = @movie.reviews.build(review_params)
    @review.user_id = current_user.id

    if @review.save
      redirect_to @movie, notice: "Review created successfully"
    else
      render :new
    end
  end

  protected

  def load_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:text, :rating_out_of_ten)
  end

end
