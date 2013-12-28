class ExceptionToAvailability < ActiveRecord::Base
  belongs_to :hours_available

  validates :hours_available, :presence => true

  validates :name, :presence => true

  validates :open, :presence => true
  validates :close, :presence => true

  validate :datetimes_are_valid
private
  def datetimes_are_valid
    errors.add :close, 'time cannot be before now' if close && close < Time.now
    errors.add :open, 'time cannot be before close time' if open && open < close
  end
public

end
