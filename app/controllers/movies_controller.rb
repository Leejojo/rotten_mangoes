class MoviesController < ApplicationController
  
  def index
    @movies = Movie.all
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
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  def new_search
    # show search form
    render :search_form
  end

  def search_results
    # use params from form submit to find movies
    @movies = Movie.where("title like :title AND director like :director", {title: params[:title], director: params[:director]})
    @movies = @movies.where("runtime_in_minutes < ? ", 90) if params[:runtime_in_minutes] == "<90"
    @movies = @movies.where("runtime_in_minutes >= ? AND runtime_in_minutes <= ? ", 90, 120) if params[:runtime_in_minutes] == "between"
    @movies = @movies.where("runtime_in_minutes > ? ", 120) if params[:runtime_in_minutes] == ">120"    
    # show movies
    render :results
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image
    )
  end


  
end
