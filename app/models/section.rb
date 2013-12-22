class Section < ActiveRecord::Base
  has_many :sectionalizations, :dependent => :destroy
  has_many :menus, :through => :sectionalizations

  #move, remove, add################################################################################

  serialize :item_order, Array
  has_many :items, :after_add => :add_to_item_order,
           :after_remove => :remove_from_item_order

  def add_to_item_order(item)
    item_order = read_attribute(:item_order)
    item_order << item.to_param
    self.update(:item_order => item_order)
  end

  def remove_from_item_order(item)
    item_order = read_attribute(:item_order)
    item_order.delete(item.to_param)
    self.update(:item_order => item_order)
  end

  def move_item(item, velocity)
    item_order = read_attribute(:item_order)
    from_index = item_order.index(item.to_param)
    item_order.move!(from_index, from_index + Integer(velocity))
    self.update(:item_order => item_order)
  end

  def ordered_items
    query = items
    arr = []
    item_order.each do |i|
      arr << query.where(:id => i).first
    end
    arr
  end
  #move, remove, add################################################################################

  validates :name, :presence => true

  def sectionalization(menu)
    Sectionalization.where(:section_id => self.id).where(:menu_id => menu.id).first
  end

end
