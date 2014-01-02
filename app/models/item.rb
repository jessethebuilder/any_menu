class Item < ActiveRecord::Base
  belongs_to :section

  validates :cost, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :name, :presence => true

  validates :section, :presence => true

  has_attached_file :image, :styles => { :show => "480x480>", :thumb => "150x150>"},
                             :default_url => "/images/:style/missing.png"
end
