require 'rails_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_title('Sign In') }
    it { should have_content('Sign In') }

    describe 'signin process' do
      let(:submit) { 'Sign In' }
      let(:user) { User.create(name: "Gerry Pass", email: "rgpass@gmail.com",
                            password: "foobar", password_confirmation: "foobar") }
      context 'valid information' do
        before { sign_in user }

        it { should have_title(user.name) }

      end

      context 'invalid information' do
      end
    end
  end
end