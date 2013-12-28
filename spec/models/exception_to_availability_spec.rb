require 'spec_helper'

describe ExceptionToAvailability do
  let(:sunday_availability){ build :hours_available_with_sunday }
  let(:eta){ build :exception_to_availability }

  describe 'Validation' do
    it{ should validate_presence_of :hours_available}
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :open }
    it{ should validate_presence_of :close }


    describe 'open and close validations' do
      it 'should validate that #open is after Now' do
        Timecop.freeze(2013, 12, 15)
        eta.close = Time.parse("14-12-2013")
        eta.valid?.should == false
        eta.errors[:close].should include("time cannot be before now")
        Timecop.return
      end

      it 'should validate that #close is before #open' do
        eta.close = Time.parse("15-12-2013")
        eta.open = Time.parse("14-12-2013")
        eta.valid?.should be_false
        eta.errors[:open].should include("time cannot be before close time")
      end
    end
  end #Validations
end
