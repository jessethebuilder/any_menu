class ExceptionToAvailability < ActiveRecord::Base
  belongs_to :hours_available

  validates_presence_of :hours_available
  validates_presence_of :name
end
