class Store < ActiveRecord::Base
    def self.all_categories
	%w(Drinks Italian Groceries Chinese Cafe)
    end
    def self.find_stores_with_same_category(store)
	raise ArgumentError if store.category.blank?
	Store.all.where(category: store.category)
    end
end

