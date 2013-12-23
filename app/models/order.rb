class Order < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user

  has_many :order_items
end
