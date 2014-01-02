u = User.new(:email => 'info@any-menu.com', :password => 'testtest', :user_type => 'owner')
u.save

s = Store.new(:name => "Japanese Letters",
              :description => "A great online ordering experience",
              :sales_tax_rate => Random.rand(0.0..15.0),
              :menu_package => 'single_menu',
              :delivers => true,
              :dine_in => true,
              :facebook_app_id => '1438033749758995',
              :average_wait_time => 20
             )
hours = HoursAvailable.new
DAYS.each do |day|
  hours.send("#{day}_open=", "9:00AM")
  hours.send("#{day}_close=", "9:00AM")
end

s.hours_available = hours
s.save!

m = Menu.new(:name => "Japanese Letters", :description => "A great online ordering experience.")
s.menus << m
m.save!
#m.hours_available = hours.dup

['Appetizers', 'Entrees'].each do |section_name|
  sec = Section.new :name => section_name, :description => Faker::Lorem.paragraph(sentence_count = 1)
  sec.save!
    10.times do
      i = Item.new :name => "Chicken and Grits",
                   :cost => 11.95,
                   :description => "Eat it with butter and gravy!",
                   :long_description => "My love affair with Chicken and Grits began when I was a little girl.
                                         I remember every summer, my Great Aunt Megatron would take us to her summer villa,
                                         and we would drink all night and eat Chicken and Grits at 4:00 in the morning."
      i.image = File.new("#{Rails.root}/app/assets/images/temp/chicken-with-grits-final-l450.jpg")
      sec.items << i
    end
  m.sections << sec
 end
m.save!

3.times do
  free_section = Section.new :name => Faker::Commerce.color.titlecase, :description => Faker::Lorem.paragraph(sentence_count = 1)
  free_section.save!
end

