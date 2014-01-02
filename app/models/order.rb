class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_items, :dependent => :delete_all
  accepts_nested_attributes_for :order_items, :allow_destroy => true

  has_one :address, :as => :addressable

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

  #Special validations
  validate :name_and_phone_exist
  validate :order_is_placed_before_close

  private

  def name_and_phone_exist
    if status == 'completing'
      errors.add :contact_name, 'contact name must be included to complete order' if contact_name.blank?
      errors.add :contact_phone, 'contact phone number must be included to complete order' if contact_phone.blank?
    end
  end

  def order_is_placed_before_close
    if place_order_at
      errors.add :place_order_at, 'is after we close.' unless store.open?(place_order_at)
    end
  end

  public



  STATUSES = %w[completing]
  validates :status, :inclusion => {:in => STATUSES}, :allow_blank => true

  PAYMENT_METHODS = %w|cash check|

  #Calculated Methods
  def order_items_total
    order_items.collect{ |oi| oi.item_total }.reduce(:+)
  end

  def tax
    order_items.collect{ |oi| oi.tax }.reduce(:+)
  end

  def total
    #untested
    order_items_total + tax
  end


end
