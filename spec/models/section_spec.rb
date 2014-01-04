require 'spec_helper'

describe Section do
  let(:section){ build :section }
  let(:menu){ build :menu }

  describe 'validations' do
    it{ should validate_presence_of :name }
  end

  describe '#sectionalization(menu)' do
    it 'should return the sectionalization to between self and menu param' do
      menu.save!
      menu.sections << section
      section.sectionalization(menu).should == Sectionalization.last
    end
  end


  describe 'item_order' do
    before(:each) do
      section.save!
      3.times do
        section.items << create(:item)
      end
    end

    it 'should have 3 elements' do
      section.item_order.count.should == 3
    end

    it 'should be an Array' do
      section.item_order.class.should == Array
    end

    it 'should add the id of any item added to section at the end of the Array' do
      new_item = create :item
      section.items << new_item
      section.item_order.last.should == new_item.id
    end

    it 'should remove item_id from item_order when item is removed' do
      new_item = create :item
      section.items << new_item
      item_id = new_item.id
      section.items.delete(new_item)
      section.item_order.should_not include(item_id)
    end

    describe '#move_item(item, velocity)' do
      specify 'it expects 2 parameters: a item and a positive or negative integer' do
        test_item = Item.first
        section.move_item(test_item, 1)
        section.item_order[1].should == test_item.id

        test_item2 = Item.last
        section.move_item(test_item2, -1)
        section.item_order[1].should == test_item2.id
      end

      specify 'velocities that outside of #item_order array bounds loop around' do
        test_item = Item.first
        section.move_item(test_item, -1)
        section.item_order.last.should == test_item.id

        section.move_item(test_item, 1)
        section.item_order.first.should == test_item.id
      end
    end

    describe 'ordered_items' do
      it 'should order the items according to attr item_order (described below)' do
        s1 = section.items.first
        s2 = section.items.last
        section.ordered_items.first.should == s1
        section.ordered_items.last.should ==s2
        section.move_item(s1, 2)
        section.ordered_items.last.should == s1
        section.move_item(s2, -1)
        section.ordered_items.first.should == s2
      end
    end
  end #describe #item_order

end