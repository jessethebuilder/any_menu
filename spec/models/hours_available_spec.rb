require 'spec_helper'

describe HoursAvailable do
  let(:hours){ build :hours_available_with_sunday }
  # :hours_with_sunday is open from 8:00AM to 8:00PM on Sunday.
  # 12/15/2013 is a Sunday
  let(:hours_available){ build :hours_available }
  let(:store){ build :store }

  #describe 'validations' do
  #  it 'should RAISE an error if a record is saved without an '
  #end

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
      #the 16th is a monday, which is set to nil
      Timecop.freeze(Time.local(2013, 12, 16, 10, 0))
      hours.open?.should be_false
    end

    it 'should always be open all day if hours_open and hours_closed is the same' do
      hours.sunday_open = "12:00AM"
      hours.sunday_close = "12:00AM"
      10.times do
        Timecop.freeze(Time.local(2013, 12, 15, Random.rand(0..23), Random.rand(0..59)))
        hours.open?.should be_true
      end
    end
  end

  describe "#availability_exception?(datetime)" do
    it 'should return false if any ExceptionToAvailability on this HoursAvailable has been set on the datetime param' do
      eta = ExceptionToAvailability.new(:name => Faker::Commerce.color)
      eta.hours_available = hours
      eta.open = Time.local(2013, 12, 15)
      eta.close = Time.local(2013, 12, 16)
      eta.save!

      Timecop.freeze(Time.local(2013, 12, 15))
      hours.availability_exception?(Time.now).should be_true
      Timecop.freeze(Time.local(2013, 12, 17))
      hours.availability_exception?(Time.now).should be_false
    end
  end

  describe '#open_next' do
  end

  describe '#owner_record (private)' do
    it 'should return the record that owns this HoursAvailable' do
      store.hours_available = hours_available
      store.save!
      hours_available.send(:owner_record).should == store
    end

    it 'should return nil if there is no owner_record (no menu_id or store_id)' do
      hours_available.send(:owner_record).should be_nil
    end
  end

  describe '#path_back' do
    it 'should return the path back to the edit page of the owner record' do
      store.hours_available = hours_available
      store.save!
      hours_available.path_back.should == "/stores/#{store.id}/edit"
    end

    it 'should raise an error if owner_record is nil' do
      expect{ hours_available.path_back }.to raise_error()
    end
  end



end