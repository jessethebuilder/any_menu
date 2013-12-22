require 'spec_helper'

describe ApplicationHelper do
  let(:my_store){ create :store }
  let(:user){ create :user }

  describe '#store' do
    it 'should return the first and only store in the db' do
      my_store.save
      store.should == my_store
    end
  end

  describe '#store_name' do
    it 'does that' do
      my_store.save
      store_name.should == my_store.name
    end
  end

  describe '#first_use?' do
    it 'should return true if no store is saved' do
      first_use?.should == true
      my_store.save
      first_use?.should == false
    end
  end

  describe '#owner?' do
    it 'returns true of current_user is an owner' do
      pending
    end

    it 'returns false if there is no owner' do
      pending
      #owner?.should be_false
    end
  end

  describe '#super_user?' do
    it 'returns true if user is an owner or store_user' do
      pending
    end
  end

  describe '#current_menu' do
    # returns store.current_menu, but is the goto helper for current_menu for future expansion.
  end


end