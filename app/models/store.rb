class Store < ActiveRecord::Base
    def self.all_categories
	%w(Drinks Italian Groceries Chinese Cafe)
    end
    def self.find_stores_with_same_category(store)
	raise ArgumentError if store.category.blank?
	Store.all.where(category: store.category)
    end
  
  def self.search_stores(search)
    puts("\n\nI HAVE BEEN CALLED")
    puts(search)
    if search
      store_type = Store.where(name: search)
      puts(store_type)
      puts("HELLO\n\n")
      if store_type
        @stores = store_type
        puts("END\n\n")
        return store_type
      else
        @stores = Store.all
      end
    else
      puts("this happened\n\n")
      @stores = Store.all
    end
  end
  
  
end

