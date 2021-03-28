class StoresController < ApplicationController
    
  def show
    id = params[:id] 
    @store = Store.find(id) 
  end
    
  def index
    if params[:search] != "" and !params[:search].nil? #if non-empty search entry
      @stores = Store.search_stores(params[:search])
      @selected_categories = {}
      @all_categories = Store.all_categories
      if @stores.blank?
        flash[:notice] = "Your search query found no results :(" 
        @stores = Store.all
      end
      return
    elsif params[:search] == ""
      flash[:notice] = "Please input a search query!"
    end

    
    #code for unselecting a sort
    if session[:changed_sort] and !params[:sort].nil? and params[:sort] == session[:sort]
      params[:sort] = nil
      session[:sort] = nil
      session[:changed_sort] = false
    end
    if !session[:changed_sort] 
      session[:changed_sort] = true
    end
    
    sort = params[:sort] || session[:sort]
    
    case sort
    when 'name'
      ordering,@name_header = {:name => :asc}, 'bg-warning hilite'
    when 'description'
      ordering,@description_header = {:description => :asc}, 'bg-warning hilite'
    when 'rating'
      ordering,@rating_header = {:rating => :desc}, 'bg-warning hilite'
    end
    @all_categories = Store.all_categories
    @selected_categories = params[:categories] || session[:categories] || {}

    if @selected_categories == {}
      @selected_categories = Hash[@all_categories.map {|category| [category, category]}]
    end
    
    if params[:sort] != session[:sort] or params[:categories] != session[:categories]
      session[:sort] = sort
      session[:categories] = @selected_categories
      session[:changed_sort] = false
      redirect_to :sort => sort, :categories => @selected_categories and return
    end

    @stores = Store.where(category: @selected_categories.keys).order(ordering)
  end

  def new
    # default: render 'new' template
  end

  def create
    new_params = {}
    new_params[:name] = order_params[:name]
    new_params[:deliver_to] = order_params[:deliver_to]
    new_params[:item] = order_params[:item]
    new_params[:user_id] = current_user.id
    new_params[:status] = 'pending'
    @order = Order.create!(new_params)
    puts order_params
    flash[:notice] = "#{@order.item} was successfully ordered."
    redirect_to '/stores'
  end

    
  def my_orders
      id = current_user.id
      puts id
      
      @my_orders = Order.where(user_id: id)

      if @my_orders.nil?
          @my_orders = []
      end
      if params[:id] != 'id'
          @my_orders.delete(Order.find_by(user_id: id))
      end
  end   
 
  def orders
      if params[:id] != 'id'
          Order.find(params[:id]).update_attributes(:status => "%s delivering" % current_user.username)
      end
      @orders = Order.all
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
	flash[:notice] = "This feature has not been implemented yet! :)"
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

  def order_params
    params.require(:order).permit(:name, :image, :item, :deliver_to)
  end
  helper_method :order_accepted, :add_order
end
