class Sectionalization < ActiveRecord::Base
  belongs_to :menu
  belongs_to :section

  before_validation do |record|
    query = Sectionalization.where(:menu_id => menu_id).where(:section_id => section_id)
    unless query.empty?
      raise ArgumentError, 'This sectionalization exists'
    end
  end
end