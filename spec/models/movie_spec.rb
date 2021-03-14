require 'rails_helper'

describe Store do
    describe 'finding stores with same rating' do
	context 'store has a rating' do
	    let(:current_store) { instance_double(Store, :id => 1, :name => 'test', :rating => "G", :description => 'test-description') }
	    it 'queries the db for any further stores with rating' do
		expect(Store).to receive_message_chain(:all,:where).with(hash_including(rating: current_store.rating))
		Store.find_stores_with_same_rating(current_store)
	    end
	end
	context 'store has no rating' do
	    let(:current_store) { instance_double(Store, :id => 1, :name => 'test', :rating => "", :description => 'test-description') }
	    it 'throws an exception when there is no rating' do
		expect {Store.find_stores_with_same_rating(current_store)}.to raise_error(ArgumentError)
	    end
	end
    end
end
