class HoursAvailable < ActiveRecord::Base
  has_many :menus
  has_many :stores

  #DAYS.each do |day|
  #  define_method("#{day}_open".to_sym) do
  #    format_time(read_attribute("#{day}_open".to_sym))
  #  end
  #
  #  define_method("#{day}_close".to_sym) do
  #    format_time(read_attribute("#{day}_close".to_sym))
  #  end
  #end

  def open?
    time = Time.now
    day = day_of_week(time).downcase
    if self.send("#{day}_open")
      time >= time_to_today(self.send("#{day}_open")) && time <= time_to_today(self.send("#{day}_close"))
    else
      false
    end
  end

  def day_of_week(date)
    date.strftime("%A")
  end

  private

  def time_to_today(datetime)
    datetime ? Time.parse(format_time(datetime)) : nil
  end

  def format_time(time)
    time ? time.strftime("%I:%M%p") : nil
  end
end
