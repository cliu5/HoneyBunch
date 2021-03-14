class StoresController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @store = Store.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
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

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    flash[:notice] = "Store '#{@store.name}' deleted."
    redirect_to stores_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def store_params
    params.require(:store).permit(:name, :rating, :description)
  end
end
