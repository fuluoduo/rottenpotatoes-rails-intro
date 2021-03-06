class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    if request.original_url =~ /title/
	@movies = Movie.order('title ASC')
    elsif request.original_url =~ /release/
	@movies = Movie.order('release_date ASC')    
    else
        @movies = Movie.all
    end
    
    #@rating_filter=session[:ratings].keys unless session[:ratings].nil?
    #if params[:sort].nil?
    #  @sort = session[:sort] 
    #else
     # @sort = params[:sort]
     # session[:sort] = params[:sort]
    #end
    #order = params[:order]
    #@movies = Movie.where(:rating => @rating_filter).order(order)
    #redirect_to movies_path(@movie)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
