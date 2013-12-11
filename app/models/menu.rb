class Menu < ActiveRecord::Base
  has_many :sectionalizations
  has_many :sections, :through => :sectionalizations

  belongs_to :store
  validates :store_id, :presence => true

  has_one :hours_available
end
