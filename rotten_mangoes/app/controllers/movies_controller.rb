require 'pry'

class MoviesController < ApplicationController
  

  def index
    # => http://www.justinweiss.com/blog/2014/02/17/search-and-filter-rails-models-without-bloating-your-controller/
    @search = Movie.all
    @search = @search.by_title(params[:title]) if params[:title].present?
    @search = @search.by_director(params[:director]) if params[:director].present?
    @search = @search.by_category(params[:category]) if params[:category].present?

    if params[:runtime_select].present?
      case params[:runtime_select]
      when 1 # => 'Less than 90 mins'
        @search = @search.duration_less_than_90
      when 2 # => 'Between 90 and 120 mins'
        @search = @search.duration_between_90_and_120
      when 3 # => 'Greater than 120 mins'
        @search = @search.duration_greater_than_120
      end
    end

    @movies = @search.order(title: :asc).page(params[:page]).per(5)


    # => Ransack search gem. Uncomment to use              
    # @search = Movie.ransack(search_params)
    # @movies = @search.result

  end

  def show
  	@movie = Movie.find(params[:id])
  end

  def new
  	@movie = Movie.new
  end

  def edit
  	@movie = Movie.find(params[:id])
  end

  def create
  	@movie = Movie.new(movie_params)

  	if @movie.save
  		redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
  	else
  		render :new
  	end
  end

  def update
    @movie = Movie.find(params[:id])
    
  	if @movie.update_attributes(movie_params)
  		redirect_to movies_path, notice: "#{@movie.title} was updated successfully!"
  	else
  		render :edit
  	end
  end

  def destroy
  	@movie = Movie.find(params[:id])
  	@movie.destroy
  	redirect_to movies_path, notice: "#{@movie.title} was deleted successfully!"
    else
  end

  protected
  def movie_params
	params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :image, :remote_image_url, :description, :category
    )
  end

end
