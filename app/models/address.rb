class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true

  #validates :name, :presence => true

  geocoded_by :address_for_geocode

  def address_for_geocode
    str = "#{street} " if street
    str += "#{street2} " if street2
    str += "#{city}, " if city
    str += "#{street} " if street
    str += zip if zip
    str
  end
end
