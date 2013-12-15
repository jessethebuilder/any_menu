require 'spec_helper'

describe HoursAvailable do
  let(:hours){ create :hours_available_with_sunday }
  # :hours_with_sunday is open from 8:00AM to 8:00PM on Sunday.
  # 12/15/2013 is a Sunday

  describe '#open?' do
    it 'should return true if current time is between day_open and day_close' do
      Timecop.freeze(Time.local(2013, 12, 15, 9, 0))
      hours.open?.should be_true
    end

    it 'should return false if current time is not' do
      Timecop.freeze(Time.local(2013, 12, 15, 7, 0))
      hours.open?.should be_false
    end

    it 'should work with a nil value' do
      Timecop.freeze(Time.local(2013, 12, 16, 10, 0))
      hours.open?.should be_false
    end
  end

end