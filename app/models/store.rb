class Store < ActiveRecord::Base

  has_many :menus

  has_many :users

  validates :name, :presence => true

  validates :sales_tax_rate, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }

  belongs_to :hours_available, :dependent => :destroy
  #todo Following line MUST be uncommented and specs pass.
  #validates :hours_available, :presence => true
  accepts_nested_attributes_for :hours_available

  validate :only_1_store, :on => :create
  def only_1_store
    errors.add :id, 'Only 1 Store can exist' unless Store.all.empty?
  end

  validates :menu_package, :presence => true, :inclusion => {:in => MENU_PACKAGES}


end
