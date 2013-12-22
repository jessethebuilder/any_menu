class Item < ActiveRecord::Base
  belongs_to :section

  validates :cost, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :name, :presence => true

  validates :section, :presence => true
end
