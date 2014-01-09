require 'spec_helper'

describe ApplicationHelper do
  let(:my_store){ build :store }
  let(:users){ create :users }

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

  describe #helpers for

  describe '#owner?' do
    it 'returns true if current_user is an owner' do
      o = create :owner
      o.owner?should be_true
    end

    it 'returns false if current_user is not an owner' do
      o = create :customer
      o.owner?.should be_false
    end
  end

  describe '#super_user?' do
    it 'returns true if user is an owner or store_user' do
      o = create :owner
      o.super_user?.should be_true

      o = create :store_user
      o.super_user?.should be_true
    end

    it 'returns false if user is not an owner or store_user' do
      o = create :customer
      o.super_user?.should be_false
    end
  end

  describe '#current_menu' do
    # returns store.current_menu, but is the goto helper for current_menu for future expansion.
  end

  describe '#current_order' do

  end
end