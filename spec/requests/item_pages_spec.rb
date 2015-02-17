require 'rails_helper'

describe 'item pages' do
  subject { page }

  describe 'index' do
    let(:user) { User.create(name: "Gerry Pass", email: "rgpass@gmail.com",
                        password: "foobar", password_confirmation: "foobar") }
    Item.destroy_all
    let(:item1) { Item.create(name: '2-person tent', rating: 4.3,
                          price: 24.99, description: 'Cuddle time',
                          image_file: 'two_person_tent.png', user_id: user.id) }
    let(:item2) { Item.create(name: 'Sleeping bag', rating: 4.3,
                          price: 24.99, description: 'Human burrito',
                          image_file: 'sleeping_bag.png', user_id: user.id) }

    before { visit items_path }

    it { should have_title('Items Index') }
    it { should have_selector('h1', text: 'All Items') }

    it "lists each item" do
      Item.all.each do |item|
        expect(page).to have_selector('li', text: item.id)
      end
    end

    # <a href="http://www.google.com">Google's Homepage</a>

    describe 'delete links' do
      let!(:item1) { Item.create(name: '2-person tent', rating: 4.3,
                            price: 24.99, description: 'Cuddle time',
                            image_file: 'two_person_tent.png') }
      let!(:item2) { Item.create(name: 'Sleeping bag', rating: 4.3,
                            price: 24.99, description: 'Human burrito',
                            image_file: 'sleeping_bag.png') }
      # visit the index -- done above already
      # click delete link
      before { visit items_path }
      it { should have_link('delete', href: item_path(Item.first)) }
      # it 'deletes that item' do
      #   expect {
      #     click_link('delete', match: :first)
      #   }.to change(Item, :count).by(-1)
      # end
      describe 'after clicking delete' do
        before { click_link('delete', match: :first) }
        it { should_not have_content('2-person tent') }
      end
      # changes Item.count by -1
      # after refreshing the page, it shouldn't have the content of the deleted item's name
    end
  end

  describe 'show' do
    let(:user) { User.create(name: "Gerry Pass", email: "rgpass@gmail.com",
                        password: "foobar", password_confirmation: "foobar") }
    let(:item) { Item.create(name: '2-person tent', rating: 4.3,
                          price: 24.99, description: 'Cuddle time',
                          image_file: 'two_person_tent.png', user_id: user.id) }

    before { visit item_path(item.id) }

    it { should have_title(item.name) }
    it { should have_selector('h1', text: item.name) }
  end

  describe 'new item page' do
    let(:user) { User.create(name: "Gerry Pass", email: "rgpass@gmail.com",
                        password: "foobar", password_confirmation: "foobar") }
    before do
      sign_in user
      visit new_item_path
    end

    it { should have_title('Add Item') }
    it { should have_selector('h1', 'Add Item') }

    describe 'create item' do
      let(:submit) { 'Save' }

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

  describe 'edit item page' do
    let(:user) { User.create(name: "Gerry Pass", email: "rgpass@gmail.com",
                        password: "foobar", password_confirmation: "foobar") }
    let(:item_for_edit) { Item.create(name: '2-person sleeping_bag', rating: 4.3,
                          price: 24.99, description: 'Cuddle time',
                          image_file: 'two_person_tent.png', user_id: user.id) }

    before do
      sign_in user
      visit edit_item_path(item_for_edit.id)
    end

    it { should have_title('Edit Item') }
    it { should have_selector('h1', 'Edit Item') }

    describe 'update item' do
      let(:submit) { 'Save' }

      context 'valid information' do

        before do
          # edit one of the fields
          fill_in "Name", with: "3-person lets get weeeeird bag"
          click_button submit
        end

        describe 'after saving changes' do
          # it has the title from item#show
          it { should have_title('3-person lets get weeeeird bag') }

          # it has the content of the change made
          specify { expect(item_for_edit.reload.name).to eq('3-person lets get weeeeird bag') }
          # ^ is the shorter way to write:
          # it 'has the updated name' do
          #   expect(item_for_edit.reload.name).to eq('3-person lets get weeeeird bag')
          # end
        end

      end

      context 'invalid information' do
        before do
          # remove the info from one of the required fields
          fill_in "Name", with: " "
          click_button submit
        end
        describe 'after submission' do
          # has the same title as item#edit
          it { should have_title('Edit Item') }
          # has the word 'error' on the page
          it { should have_content('error') }
        end
      end
    end
  end
end