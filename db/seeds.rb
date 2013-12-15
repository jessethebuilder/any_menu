u = User.new(:email => 'test@test.com', :password => 'testtest', :user_type => 'owner')
u.save

s = Store.new(:name => Faker::Company.name,
              :description => Faker::Lorem.paragraph(sentence_count = 2),
              :sales_tax_rate => Random.rand(0.0..15.0)
             )
hours = HoursAvailable.new
DAYS.each do |day|
  hours.send("#{day}_open=", "9:00AM")
  hours.send("#{day}_close=", "9:00PM")
end
s.hours_available = hours
s.save

m = Menu.new(:name => Faker::Company.name, :description => Faker::Lorem.paragraph(sentence_count = 1))
m.hours_available = hours.dup
m.store = s
m.save