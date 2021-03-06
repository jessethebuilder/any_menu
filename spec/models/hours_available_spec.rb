require 'spec_helper'

describe HoursAvailable do
  let(:hours){ build :hours_available_with_sunday }
  # :hours_with_sunday is open from 8:00AM to 8:00PM on Sunday.
  # 12/15/2013 is a Sunday
  let(:hours_available){ build :hours_available }
  let(:store){ build :store }

  after(:each) do
    Timecop.return
  end

  describe 'Validations' do
    it "validates that a day's opening is before or equal to a day's close" do
      hours_available.sunday_close = Time.parse('15-12-2013-8:59am')
      hours_available.sunday_open = Time.parse('15-12-2013-9:00am')
      hours_available.valid?.should be_false
      hours_available.errors[:sunday_close].should include("cannot be before Sunday open")
      hours_available.errors[:sunday_open].should include("cannot be after Sunday close")
      hours_available.sunday_close = Time.parse('15-12-2013-9:00am')
      hours_available.should be_valid
    end

    it 'validates that if an #closed is given, an #open exists' do
      #if #open is nil, store is closed, so #close is not evaluated.
      hours.sunday_close = nil
      hours.valid?.should be_false
      hours.errors[:sunday_open].should include('must also have a Sunday close.')
    end
  end

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
      eta.close = Time.local(2013, 12, 15)
      eta.open = Time.local(2013, 12, 16)
      eta.save(:validate => false)

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