class Store < ActiveRecord::Base
    def self.all_ratings
	%w(G PG PG-13 R NC-17)
    end

    def self.find_stores_with_same_rating(store)
	raise ArgumentError if store.rating.blank?
	Store.all.where(rating: store.rating)
    end
end
