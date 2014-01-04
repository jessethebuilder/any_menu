class HoursAvailable < ActiveRecord::Base
  has_many :menus
  has_many :stores
  has_many :exception_to_availabilities

  validate :closes_are_after_opens
  validate :opens_have_closes
private
  def opens_have_closes
    day_methods_hash.each do |day, methods|
      if read_attribute(methods[:open]) && !read_attribute(methods[:close])
        errors.add methods[:open], "must also have a #{day.to_s.titlecase} close."
      end
    end
  end

  def closes_are_after_opens
    DAYS.each do |day|
      open = "#{day}_open".to_sym
      close = "#{day}_close".to_sym

      if read_attribute(open) && read_attribute(close)
        if read_attribute(close) < read_attribute(open)
          errors.add close, "cannot be before #{day.titlecase} open"
          errors.add open, "cannot be after #{day.titlecase} close"
        end
      end
    end
  end
public

  def open?(datetime = Time.now)
    day = day_of_week(datetime).downcase
    open = send("#{day}_open")
    close = send("#{day}_close")
    if open
      if format_time(open) == format_time(close)
        #open 24 hours if open and close time are the same
        true
      else
        datetime >= time_to_today(open) && datetime <= time_to_today(close)
      end
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
      return true if datetime >= ex.close && datetime <= ex.open
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

  def day_methods_hash
    h = {}
    DAYS.each do |day|
      h[day.to_sym] = {:open => "#{day}_open".to_sym, :close => "#{day}_close".to_sym}
    end
    h
  end
end
