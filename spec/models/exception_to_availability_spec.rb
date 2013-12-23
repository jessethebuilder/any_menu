require 'spec_helper'

describe ExceptionToAvailability do
  let(:sunday_availability){ build :hours_available_with_sunday }
  let(:eta){ build :exception_to_availability }

  describe 'validation' do
    it{ should validate_presence_of :hours_available}
    it{ should validate_presence_of :name }
  end
end
