class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_items, :dependent => :delete_all
  accepts_nested_attributes_for :order_items, :allow_destroy => true

  has_one :address, :as => :addressable

  #validates :contact_phone, :presence => true
  #validates :contact_name, :presence => true

  validate :all_delivery_items_deliverable
  private
  def all_delivery_items_deliverable
    if self.dining_location == 'delivery'
      order_items.each do |oi|
        self.errors.add :order_items, "#{oi.item.name} is not available for delivery." if oi.item.dont_deliver?
      end
    end
  end

  public
end
