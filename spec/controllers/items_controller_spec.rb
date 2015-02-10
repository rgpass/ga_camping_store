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

  describe 'GET #edit' do
    let(:item_for_edit) { Item.create(name: '2-person tent', rating: 4.3,
                          price: 24.99, description: 'Cuddle time',
                          image_file: 'two_person_tent.png') }
    # Assume for discussion that item.id == 3
    it 'renders edit' do
      get :edit, id: item_for_edit.id # /items/3/edit
      expect(response).to render_template(:edit) # loads the edit template
    end

    # Want to confirm @item = Item.find(3) when we go to /items/3/edit
    it 'assigns correct item' do
      get :edit, id: item_for_edit.id
      expect(assigns(:item)).to eq(item_for_edit) # @item == item_for_edit (defined above)
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

      it 'redirects to items#index' do
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

  describe 'PATCH #update' do
    let(:item_for_edit) { Item.create(name: '2-person sleeping_bag', rating: 4.3,
                          price: 24.99, description: 'Cuddle time',
                          image_file: 'two_person_tent.png') }
    context 'valid attributes' do
      it 'updates item' do
        patch :update, id: item_for_edit.id, item: { name: '3-person sleeping_bag' }
        item_for_edit.reload
        expect(item_for_edit.name).to eq('3-person sleeping_bag')
        # If we were using instance variable for item, could do the following:
        # expect(assigns(:item).name).to eq('3-person sleeping_bag')
      end

      it 'redirects to items#show' do
        patch :update, id: item_for_edit.id, item: { name: '3-person sleeping_bag' }
        expect(response).to redirect_to(item_path(item_for_edit.id)) # item#show
      end
    end

    context 'invalid attributes' do
      it 'does not update item' do
        patch :update, id: item_for_edit.id, item: { name: '' }
        item_for_edit.reload
        expect(item_for_edit.name).to eq('2-person sleeping_bag') # aka what we started with
      end

      it 're-renders edit' do
        patch :update, id: item_for_edit.id, item: { name: '' }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes requested item' do
      item_for_removal = Item.create(name: '2-person sleeping_bag', rating: 4.3,
                          price: 24.99, description: 'Cuddle time',
                          image_file: 'two_person_tent.png')
      expect{
        delete :destroy, id: item_for_removal.id
      }.to change(Item, :count).by(-1)
    end

    it 'redirects to index' do
      item_for_removal = Item.create(name: '2-person sleeping_bag', rating: 4.3,
                          price: 24.99, description: 'Cuddle time',
                          image_file: 'two_person_tent.png')
      delete :destroy, id: item_for_removal.id
      expect(response).to redirect_to(items_path)
    end
  end
end