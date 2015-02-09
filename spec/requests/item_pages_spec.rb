require 'rails_helper'

describe 'item pages' do
  subject { page }

  describe 'index' do
    let(:item1) { Item.create(name: '2-person tent', rating: 4.3,
                          price: 24.99, description: 'Cuddle time',
                          image_file: 'two_person_tent.png') }
    let(:item2) { Item.create(name: 'Sleeping bag', rating: 4.3,
                          price: 24.99, description: 'Human burrito',
                          image_file: 'sleeping_bag.png') }

    before { visit items_path }

    it { should have_title('Items Index') }
    it { should have_selector('h1', text: 'All Items') } 
    # it { should have_link('2-person tent', href: item_path(item1.id)) }
  end

  describe 'show' do
    let(:item) { Item.create(name: '2-person tent', rating: 4.3,
                          price: 24.99, description: 'Cuddle time',
                          image_file: 'two_person_tent.png') }

    before { visit item_path(item.id) }

    it { should have_title(item.name) }
    it { should have_selector('h1', text: item.name) }
  end
end