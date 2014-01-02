module ItemsHelper
  include TwitterExpress

  def path_to_edit_item
    eval("edit_#{end_of_path}")
  end

  def path_to_item
    eval(end_of_path)
  end

  def url_to_item
    eval(end_of_url)
  end

  def path_to_edit_section
    if @menu
      edit_menu_section_path(@menu, @section)
    else
      edit_section_path(@section)
    end
  end

  private

  def end_of_path
    if @menu
      "menu_section_item_path(@menu, @section, @item)"
    else
      "section_item_path(@section, @item)"
    end
  end


  def end_of_url
    if @menu
      "menu_section_item_url(@menu, @section, @item)"
    else
      "section_item_url(@section, @item)"
    end
  end

end
