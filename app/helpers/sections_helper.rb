module SectionsHelper
  def menu_list(section)
    arr = section.menus.each.collect{ |m| link_to(m.name, edit_menu_path(m)) }
    arr.join(',').html_safe
  end
end