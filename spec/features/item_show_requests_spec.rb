require 'spec_helper'

describe 'Item Show Requests' do
  let!(:store){ create :test_store }
  it 'should only show the order button if menu is in the route' do
    m = store.current_menu
    s = m.sections.first
    i = s.items.first

    visit section_item_path(s, i)
    page.should_not have_link 'Add to Order'

    visit menu_section_item_path(m, s, i)
    page.should have_link 'Add to Order'

  end
end