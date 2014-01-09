class Store < ActiveRecord::Base
  has_many :menus

  has_many :users

  validates :name, :presence => true

  validates :sales_tax_rate, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }

  validates :phone, :presence => true

  belongs_to :hours_available, :dependent => :destroy
  #todo Following line MUST be uncommented and specs pass.
  validates :hours_available, :presence => true
  accepts_nested_attributes_for :hours_available

  validate :only_1_store, :on => :create
  def only_1_store
    errors.add :id, 'Only 1 Store can exist' unless Store.all.empty?
  end

  has_one :address, :as => :addressable#, :dependent => :destroy
  validates :address, :presence => true
  accepts_nested_attributes_for :address

  validates :menu_package, :presence => true, :inclusion => {:in => MENU_PACKAGES}

  validates :average_wait_time, :presence => true, :numericality => { :greater_than_or_equal_to => 1 }


  def dining_location_options
    arr = ['take_out']
    arr << 'delivery' if self.delivers?
    arr << 'dine_in' if self.dine_in?
    arr
  end

  def open?(time = Time.now)
    self.hours_available.open?(time)
  end

   def current_menu
     #menu selection goes through this method.
     #currently, only 1 menu is allowed, so this is easy.
     open? ? self.menus.first : nil
   end
end
