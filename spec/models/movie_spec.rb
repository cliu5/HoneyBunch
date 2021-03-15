require 'rails_helper'

describe Store do
    describe 'finding stores with same category' do
	context 'store has a category' do
	    let(:current_store) { instance_double(Store, :id => 1, :name => 'test', :rating => "G", :category => "G", :description => 'test-description') }
	    it 'queries the db for any further stores with category' do
		expect(Store).to receive_message_chain(:all,:where).with(hash_including(category: current_store.category))
		Store.find_stores_with_same_category(current_store)
	    end
	end
	context 'store has no category' do
	    let(:current_store) { instance_double(Store, :id => 1, :name => 'test', :rating => "G", :category => "", :description => 'test-description') }
	    it 'throws an exception when there is no category' do
		expect {Store.find_stores_with_same_category(current_store)}.to raise_error(ArgumentError)
	    end
	end
    end
end
