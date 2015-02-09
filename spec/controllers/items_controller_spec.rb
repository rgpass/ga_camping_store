require 'rails_helper'

describe ItemsController, type: :controller do
  # Sometimes need to do this to have RSpec work correctly
  # Item.destroy_all
  # Pre-populating fake data for our tests later
  let(:item1) { Item.create(name: '2-person tent', rating: 4.3,
                        price: 24.99, description: 'Cuddle time',
                        image_file: 'two_person_tent.png') }
  let(:item2) { Item.create(name: 'Sleeping bag', rating: 4.3,
                        price: 24.99, description: 'Human burrito',
                        image_file: 'sleeping_bag.png') }

  describe 'GET #index' do
    it 'renders index' do # loads the page
      get :index
      expect(response).to render_template(:index)
    end

    # Testing that we return all created Items
    # Testing: @items = Item.all
    it 'populate an array of items' do
      get :index
      # What this is doing:
      # expect @items == [item1, item2]
      expect(assigns(:items)).to eq([item1, item2])
    end
  end

  describe 'GET #show' do
    # Loads the details page for an item
    it 'renders show' do
      get :show, id: item1.id
      expect(response).to render_template(:show)
    end

    # When we visit /items/5
    # @item == Item where id is 5
    it 'assigns correct item' do
      get :show, id: item1.id
      expect(assigns(:item)).to eq(item1)
    end
  end

  describe 'GET #new' do
    it 'renders new' do
      get :new
      expect(response).to render_template(:new)
    end

    # Testing: @item == Item.new
    it 'assigns a new Item' do
      get :new
      expect(assigns(:item)).to be_a_new(Item)
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      let(:valid_attributes) { { name: '2-person tent', rating: 4.3,
                               price: 24.99, description: 'Blah blah',
                               image_file: 'two_person_tent.png' } }
# Why double bracket?
# let(:item) { Item.new }
# is like saying: item = Item.new
# valid_attributes = { name: '' }
# let(valid_attributes) { { name: '' } }

      it 'create new item' do
        expect{
          post :create, item: valid_attributes
        }.to change(Item, :count).by(1)
      end

      it 'redirect to items#index' do
        post :create, item: valid_attributes
        expect(response).to redirect_to(items_path)
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) { { name: '' } }

      it 'does not create new item' do
        expect{
          post :create, item: invalid_attributes
        }.to_not change(Item, :count)
      end

      it 're-renders new' do
        post :create, item: invalid_attributes
        expect(response).to render_template(:new)
      end
    end
  end
end