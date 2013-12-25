class OrderItem < ActiveRecord::Base
  validates :quantity, :numericality => {:integer_only => true, :greater_than_or_equal_to => 0,
                                         :allow_nil => true}

  belongs_to :item
  validates :item, :presence => true

  belongs_to :order
  #validates :order, :presence => true

  validates :cost, :presence => true, :numericality => {:greater_than_or_equal_to => 0}

  before_save do |r|
    #if no quantity is included, 1 is assumed
    r.quantity = 1 if r.quantity.nil?
  end

  def item_total
    item.cost * quantity
  end

end
