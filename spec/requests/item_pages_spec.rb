require 'rails_helper'

describe 'item pages' do
  subject { page }

  describe 'index' do
    Item.destroy_all
    let(:item1) { Item.create(name: '2-person tent', rating: 4.3,
                          price: 24.99, description: 'Cuddle time',
                          image_file: 'two_person_tent.png') }
    let(:item2) { Item.create(name: 'Sleeping bag', rating: 4.3,
                          price: 24.99, description: 'Human burrito',
                          image_file: 'sleeping_bag.png') }

    before { visit items_path }

    it { should have_title('Items Index') }
    it { should have_selector('h1', text: 'All Items') }

    it "lists each item" do
      Item.all.each do |item|
        expect(page).to have_selector('li', text: item.id)
      end
    end
  end

  describe 'show' do
    let(:item) { Item.create(name: '2-person tent', rating: 4.3,
                          price: 24.99, description: 'Cuddle time',
                          image_file: 'two_person_tent.png') }

    before { visit item_path(item.id) }

    it { should have_title(item.name) }
    it { should have_selector('h1', text: item.name) }
  end

  describe 'new item page' do
    before { visit new_item_path }

    it { should have_title('Add Item') }
    it { should have_selector('h1', 'Add Item') }

    describe 'create item' do
      let(:submit) { 'Create Item' }

      context 'valid information' do
        before do
          # fill in all necessary info in the fields
          fill_in 'Name',   with: '2-person tent'
          fill_in 'Price',  with: '25.00'
        end

        it 'creates item' do
          expect { click_button submit }.to change(Item, :count).by(1)
        end

        describe 'after saving' do
          # Testing that it goes to the correct path
          # after saving
          before { click_button submit }

          it { should have_title('Items Index') }
        end
      end

      context 'invalid information' do
        it 'does not create item' do
          expect { click_button submit }.not_to change(Item, :count)
        end

        describe 'after submission' do
          before { click_button submit }

          it { should have_title('Add Item') }
          it { should have_content('error') }
        end
      end
    end
    # Fill out information in the form(s)

    # Try to save it
      # If it works, it forwards to the correct page
      # If it doesn't work, reloads with an error message
  end
end