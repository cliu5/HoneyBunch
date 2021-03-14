class StoresController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @store = Store.find(id)
  end

  def index
    @stores = Store.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @store = Store.create!(store_params)
    flash[:notice] = "#{@store.name} was successfully created."
    redirect_to store_path
  end

  def edit
    @store = Store.find params[:id]
  end

  def update
    @store = Store.find params[:id]
    @store.update_attributes!(store_params)
    flash[:notice] = "#{@store.name} was successfully updated."
    redirect_to store_path(@store)
  end

  def search_for_same_rating
    @store = Store.find(params[:id])

    begin
	@stores = Store.find_stores_with_same_rating(@current_store)
	#redirect_to stores_with_same_rating_path
    rescue
	flash.keep
	flash[:notice] = "no rating info available"
	#flash[:notice] = "'#{@current_store.name}' has no rating info"
	#the above line should fix the last feature but name is an undefined method
	redirect_to '/stores'
    end
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def store_params
    params.require(:store).permit(:name, :rating, :description)
  end
end
