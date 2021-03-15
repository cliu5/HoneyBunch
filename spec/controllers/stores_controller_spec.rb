require 'rails_helper'

#https://github.com/rails/rails/issues/34790
if RUBY_VERSION>='2.6.0'
    if Rails.version < '5'
	class ActionController::TestResponse < ActionDispatch::TestResponse
	    def recycle!
		@mon_mutex_owner_object_id = nil
		@mon_mutex = nil
		initialize
	    end
	end
    else
	puts "Monkeypatch for ActionController::TestResponse no longer needed"
    end
end

describe StoresController do

    before :each do
	@store_class = class_double('Store').as_stubbed_const
	@store_attributes = {:name => 'test', :rating => 'G', :description => '2020-01-01'}
    end
    describe 'Find Stores With Same Rating' do

	before :each do
	    @results = [double('store1'), double('store2')]
	    @current_store = double('store')
	    allow(@store_class).to receive(:find).and_return(@current_store)
	end

	context 'store has rating' do
	    it 'selects search results template for render' do
		allow(@store_class).to receive(:find_stores_with_same_rating).and_return(@results)
		get :search_for_same_rating, {id: '1'}
		expect(response).to render_template('search_for_same_rating')
	    end
	    it 'makes results available to the template' do
		allow(@store_class).to receive(:find_stores_with_same_rating).and_return(@results)
		get :search_for_same_rating, {id: '1'}
		expect(assigns(:stores)).to eq(@results)
	    end
	end
	context 'store has no rating' do
	    subject { get :search_for_same_rating, {id: '1'} }
	    it 'redirects to home' do
		other_store = double('store')
		allow(other_store).to receive(:rating).and_return('')
		allow(other_store).to receive(:name).and_return('test')
		allow(@store_class).to receive(:find).and_return(other_store)
		allow(@store_class).to receive(:find_stores_with_same_rating).and_raise(ArgumentError)
		expect(subject).to redirect_to(stores_path)
	    end
	end
    end

    describe 'update store' do
	let(:current_store) { instance_double(Store, :id => 1, :name => 'test') }
	it 'updates a movie' do
	    allow(@store_class).to receive(:find).with("1").and_return(current_store)
	    expect(current_store).to receive(:update_attributes!).with(@store_attributes)
	    put :update, {:id => 1, :store => @store_attributes}
	end
	let(:current_store) { instance_double(Store, :name => 'test') }
	it 'redirects to home' do
	    allow(@store_class).to receive(:find).with("1").and_return(current_store)
	    allow(current_store).to receive(:update_attributes!).with(@store_attributes)
	    put :update, {:id => 1, :store => @store_attributes}
	    expect(response).to redirect_to store_path(current_store)
	end
    end

    describe 'delete store' do
	let(:current_store) { instance_double(Store, :id => 1, :name => 'test') }
	it 'deletes the movie' do
	    allow(@store_class).to receive(:find).with("1").and_return(current_store)
	    expect(current_store).to receive(:destroy)
	    delete :destroy, {:id => 1, :store => @store_attributes}
	end
    end

    describe 'show stores' do
	it 'on name' do
	    all_ratings = ['rating1', 'rating2']
	    allow(@store_class).to receive(:all_ratings).and_return(all_ratings)
	    allow(@store_class).to receive(:where)
	    get :index, {:sort => 'name'}
	    expect(assigns(:name_header)).to eq 'bg-warning hilite'
	end

	it 'on description' do
	    all_ratings = ['rating1', 'rating2']
	    allow(@store_class).to receive(:all_ratings).and_return(all_ratings)
	    allow(@movie_class).to receive(:where)
	    get :index, {:sort => 'description'}
	    expect(assigns(:description_header)).to eq 'bg-warning hilite'
	end
    end 
end
