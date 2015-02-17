require 'rails_helper'

describe 'user pages' do
  subject { page }

  describe 'index' do
    User.destroy_all
    let(:user1) { User.create(name: "Gerry Pass", email: "rgpass@gmail.com",
                        password: "foobar", password_confirmation: "foobar") }
    let(:user2) { User.create(name: "Marcus Aurelius", email: "marcus@gmail.com",
                        password: "foobar", password_confirmation: "foobar") }

    before { visit users_path }

    it { should have_title('All Users') }
    it { should have_selector('h1', text: 'All Users') }

    it "lists each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.id)
      end
    end

    # <a href="http://www.google.com">Google's Homepage</a>

    describe 'delete links' do
      let!(:user1) { User.create(name: "Gerry Pass", email: "rgpass@gmail.com",
                          password: "foobar", password_confirmation: "foobar") }
      let!(:user2) { User.create(name: "Marcus Aurelius", email: "marcus@gmail.com",
                          password: "foobar", password_confirmation: "foobar") }
      let(:admin)  { User.create(name: "Mike Hopper", email: "mike@gmail.com",
                          password: "foobar", password_confirmation: "foobar", admin: true) }
      # visit the index -- done above already
      # click delete link
      before do
        sign_in admin
        visit users_path
      end

      it { should have_link('delete', href: user_path(User.first)) }
      # it 'deletes that user' do
      #   expect {
      #     click_link('delete', match: :first)
      #   }.to change(User, :count).by(-1)
      # end
      describe 'after clicking delete' do
        before { click_link('delete', match: :first) }
        it { should_not have_content('Gerry Pass') }
      end
      # changes User.count by -1
      # after refreshing the page, it shouldn't have the content of the deleted user's name
    end
  end

  describe 'show' do
    let(:user) { User.create(name: "Gerry Pass", email: "rgpass@gmail.com",
                        password: "foobar", password_confirmation: "foobar") }

    before { visit user_path(user.id) }

    it { should have_title(user.name) }
    it { should have_selector('h1', text: user.name) }
  end

  describe 'new user page' do
    before { visit signup_path }

    it { should have_title('Sign Up') }
    it { should have_selector('h1', 'Sign Up') }

    describe 'create user' do
      let(:submit) { 'Save' }

      context 'valid information' do
        before do
          # fill in all necessary info in the fields
          fill_in 'Name',             with: 'Gerry Pass'
          fill_in 'Email',            with: 'rgpass@gmail.com'
          fill_in 'Password',         with: 'foobar'
          fill_in 'Confirm password', with: 'foobar'
        end

        it 'creates user' do
          expect { click_button submit }.to change(User, :count).by(1)
        end

        describe 'after saving' do
          # Testing that it goes to the correct path
          # after saving
          before { click_button submit }

          it { should have_title('Gerry Pass') }
        end
      end

      context 'invalid information' do
        it 'does not create user' do
          expect { click_button submit }.not_to change(User, :count)
        end

        describe 'after submission' do
          before { click_button submit }

          it { should have_title('Sign Up') }
          it { should have_content('error') }
        end
      end
    end
    # Fill out information in the form(s)

    # Try to save it
      # If it works, it forwards to the correct page
      # If it doesn't work, reloads with an error message
  end

  describe 'edit user page' do
    let(:user_for_edit) { User.create(name: "Gerry Pass", email: "rgpass@gmail.com",
                        password: "foobar", password_confirmation: "foobar") }

    before do
      sign_in user_for_edit
      visit edit_user_path(user_for_edit.id)
    end

    it { should have_title('Edit Profile') }
    it { should have_selector('h1', 'Edit Profile') }

    describe 'update user' do
      let(:submit) { 'Save' }

      context 'valid information' do

        before do
          # edit one of the fields
          fill_in "Name", with: "Richard the Fifth"
          click_button submit
        end

        describe 'after saving changes' do
          # it has the title from user#show
          it { should have_title('Richard the Fifth') }

          # it has the content of the change made
          specify { expect(user_for_edit.reload.name).to eq('Richard the Fifth') }
          # ^ is the shorter way to write:
          # it 'has the updated name' do
          #   expect(user_for_edit.reload.name).to eq('Richard the Fifth')
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
          # has the same title as user#edit
          it { should have_title('Edit Profile') }
          # has the word 'error' on the page
          it { should have_content('error') }
        end
      end
    end
  end
end