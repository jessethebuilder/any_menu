ENTREES = {:chicken_and_grits => "Southern fried chicken that has been marinading in herbs and buttermilk served over fresh,
                                  buttery grits with gravy. Homestyle or redeye. We recommend the redeye.",
           :taters_and_onions => "Served with ketchup and salt.",
           :agadashi_tofu => "Fresh, organic, deep-fried silken tofu with ginger, daikon, and spring onion.",
           :bachelor_steak => "A premium T-bone cooked in salt and butter over a blazing hot skillet with herbs, mushrooms, and garlic.",
           :turkey_dinner => "Smoked white and dark meat with bacon, served with pureed potatoes and butter, cranberry relish, and roasted butternut squash with sesame."
}

u = User.new(:email => 'info@any-menu.com', :password => 'testtest', :user_type => 'owner')
u.save

s = Store.new(:name => "Japanese Letters",
              :description => "A great online ordering experience",
              :sales_tax_rate => Random.rand(0.0..15.0),
              :menu_package => 'single_menu',
              :delivers => true,
              :dine_in => true,
              :facebook_app_id => '1438033749758995',
              :facebook_secret => 'c78b3d4aa4b98b6badbcd1cbbf7af394',
              :average_wait_time => 20,
              :phone => "360-670-9312"
             )
address = Address.new(
    :street => "4218 Mt. Angeles Rd",
    :city => "Port Angeles",
    :state => 'wa',
    :zip => '98362'
)
s.address = address

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

['Entrees'].each do |section_name|
  sec = Section.new :name => section_name, :description => "All meals are served with all the bread you need, a fresh herb salad, and hot sauce."
  sec.save!
    ENTREES.each do |k, v|
      i = Item.new :name => k.to_s.titlecase,
                   :cost => Random.rand(8.0..24.0),
                   :description => v,
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

