require 'rails_helper'

describe Item do
  # Write out a happy path example of this model
  let(:item) { Item.new(name: '2-person tent', rating: 4.3,
                        price: 24.99, description: 'Blah blah',
                        image_file: 'two_person_tent.png') }

  subject { item }

  it { should respond_to(:name) } # item.name returns anything but an error
  it { should respond_to(:price) }
  it { should respond_to(:rating) }
  it { should respond_to(:description) }
  it { should respond_to(:image_file) }

  it { should be_valid } # It passes all validations

  describe 'validations' do
    describe 'name' do
      context 'not present' do
        before { item.name = nil }
        it { should_not be_valid }
      end

      context 'too short' do
        before { item.name = 'a' * 2 }
        it { should_not be_valid }
      end

      context 'too long' do
        before { item.name = 'a' * 255 }
        it { should_not be_valid }
      end
    end

    describe 'price' do
      context 'not present' do
        before { item.price = nil }
        it { should_not be_valid }
      end
    end

    describe 'description' do
      context 'not present' do
      end

      context 'too short' do
      end
    end

    describe 'image_file' do
      context 'not present' do
      end
    end
  end
end