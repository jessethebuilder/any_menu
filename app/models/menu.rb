class Menu < ActiveRecord::Base
  has_many :sectionalizations
  has_many :sections, :through => :sectionalizations

  belongs_to :store
  validates :store, :presence => true

  validates :name, :presence => true

  belongs_to :hours_available, :dependent => :destroy
  validates :hours_available , :presence => true
  accepts_nested_attributes_for :hours_available
end
