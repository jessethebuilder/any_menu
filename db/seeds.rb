u = User.new(:email => 'test@test.com', :password => 'testtest', :user_type => 'owner')
u.save

s = Store.new(:name => Faker::Company.name,
              :description => Faker::Lorem.paragraph(sentence_count = 2),
              :sales_tax_rate => Random.rand(0.0..15.0),
              :menu_package => 'single_menu'
             )
hours = HoursAvailable.new
DAYS.each do |day|
  hours.send("#{day}_open=", "9:00AM")
  hours.send("#{day}_close=", "9:00PM")
end
s.hours_available = hours
s.save!

m = Menu.new(:name => Faker::Company.name, :description => Faker::Lorem.paragraph(sentence_count = 1))
s.menus << m
m.save!
#m.hours_available = hours.dup
3.times do
  sec = Section.new :name => Faker::Commerce.color.titlecase, :description => Faker::Lorem.paragraph(sentence_count = 1)
  sec.save!
    10.times do
      i = Item.new :name => Faker::Company.bs.titlecase, :cost => Random.rand(0..200.0)
      sec.items << i
    end
  m.sections << sec
end
m.save!

3.times do
  free_section = Section.new :name => Faker::Commerce.color.titlecase, :description => Faker::Lorem.paragraph(sentence_count = 1)
  free_section.save!
end

