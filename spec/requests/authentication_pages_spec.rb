require 'rails_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_title('Sign In') }
    it { should have_content('Sign In') }

    describe 'signin process' do
      let(:user) { FactoryGirl.create(:user) }
      context 'valid information' do
        before { sign_in user }

        it { should have_title(user.name) }
      end

      context 'invalid information' do
      end
    end
  end
end