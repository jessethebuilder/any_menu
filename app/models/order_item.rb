class OrderItem < ActiveRecord::Base
  include ApplicationHelper
  validates :quantity, :numericality => {:integer_only => true, :greater_than_or_equal_to => 0,
                                         :allow_nil => true}
  belongs_to :item
  validates :item, :presence => true

  belongs_to :order
  #validates :order, :presence => true

  validates :cost, :presence => true, :numericality => {:greater_than_or_equal_to => 0}

  validates :quantity, :presence => true, :numericality => {:greater_than_or_equal_to => 1, :only_integer => true}

  before_validation do |r|
    #if no quantity is included, 1 is assumed
    r.quantity = 1 if r.quantity.nil?
  end

  def item_total
    cost * quantity
  end

  def tax
    item.tax_exempt ? 0 : item_total * (0.01 * store.sales_tax_rate)
  end
end
