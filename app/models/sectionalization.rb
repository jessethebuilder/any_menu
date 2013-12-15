class Sectionalization < ActiveRecord::Base
  belongs_to :menu
  belongs_to :section

  before_validation do
    unless Sectionalization.where(:menu_id => menu_id).where(:section_id => section_id).empty?
      raise 'This sectionalization exists'
    end
  end
end