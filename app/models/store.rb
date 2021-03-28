class Store < ActiveRecord::Base
    def self.all_categories
	%w(Drinks Italian Groceries Chinese Cafe)
    end
    def self.find_stores_with_same_category(store)
      raise ArgumentError if store.category.blank?
      Store.all.where(category: store.category)
    end
  
  def self.search_stores(search)

    query = search.dup 
    query.strip!
    query.downcase! 
    if query 
      #query data base as all lower case
      #'game_name LIKE :search OR genre LIKE :search OR console LIKE :search', search: "%#{search}%"
      store_type = Store.all.where("lower(name) LIKE :search OR lower(category) LIKE :search OR lower(description) LIKE :search OR lower(menu) LIKE :search", search: "%#{query}%") 
      if store_type
        @search_type = 0
        @stores = store_type
      else
        @search_type = 1
        @stores = Store.all
      end
    else
      @search_type = 2
      @stores = Store.all
    end
  end
  
  
end

