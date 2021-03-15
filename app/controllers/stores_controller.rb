class StoresController < ApplicationController

  def show
    id = params[:id] 
    @store = Store.find(id) 
  end

  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'name'
	ordering,@name_header = {:name => :asc}, 'bg-warning hilite'
    when 'description'
	ordering,@description_header = {:description => :asc}, 'bg-warning hilite'
    end
    @all_categories = Store.all_categories
    @selected_categories = params[:categories] || session[:categories] || {}

    if @selected_categories == {}
	@selected_categories = Hash[@all_categories.map {|category| [category, category]}]
    end

    if params[:sort] != session[:sort] or params[:categories] != session[:categories]
	session[:sort] = sort
	session[:categories] = @selected_categories
	redirect_to :sort => sort, :categories => @selected_categories and return
    end
    @stores = Store.where(category: @selected_categories.keys).order(ordering)
  end

  def new
    # default: render 'new' template
  end

  def create
    @store = Store.create!(store_params)
    flash[:notice] = "#{@store.name} was successfully created."
    redirect_to '/stores'
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
    @store = Store.find params[:id]
    @store.destroy
    redirect_to store_path(@store)
  end

  def search_for_same_category
    @store = Store.find(params[:id])

    begin
	@stores = Store.find_stores_with_same_category(@current_store)
    rescue
	flash.keep
	flash[:notice] = "no category info available"
	#flash[:notice] = "'#{@current_store.name}' has no rating info"
	#the above line should fix the last feature but name is an undefined method
	redirect_to '/stores'
    end
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def store_params
    params.require(:store).permit(:name, :rating, :description, :menu)
  end
end
