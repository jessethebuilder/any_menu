class HoursAvailable < ActiveRecord::Base
  has_many :menus
  has_many :stores
  has_many :exception_to_availabilities

  def open?(datetime = Time.now)
    day = day_of_week(datetime).downcase
    if self.send("#{day}_open")
      datetime >= time_to_today(self.send("#{day}_open")) && datetime <= time_to_today(self.send("#{day}_close"))
    else
      false
    end
  end

  def day_of_week(date)
    date.strftime("%A")
  end

  def availability_exception?(datetime)
    exceptions = ExceptionToAvailability.where(:hours_available_id => self.id)
    exceptions.each do |ex|
      return true if datetime >= ex.open && datetime <= ex.close
    end
    false
  end

  def path_back
    record = owner_record
    raise StandardError, 'No owning record exists to build a path back' if record.nil?
    record_type = record.class.name.downcase.pluralize
    "/#{record_type}/#{record.id}/edit"
  end

  private

  def owner_record
    if menu_id
      Menu.where(:hours_available_id => id).first
    else
      Store.where(:hours_available_id => id).first
    end
  end

  def time_to_today(datetime)
    datetime ? Time.parse(format_time(datetime)) : nil
  end

  def format_time(time)
    time ? time.strftime("%I:%M%p") : nil
  end
end
