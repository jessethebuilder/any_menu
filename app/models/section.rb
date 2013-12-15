class Section < ActiveRecord::Base
  attr_accessor :id_for_menu

  has_many :sectionalizations
  has_many :menus, :through => :sectionalizations

  has_many :items

  validates :name, :presence => true

  after_save do
    Sectionalization.create(:menu_id => @id_for_menu, :section_id => self.id) unless @id_for_menu.blank?
  end

  def sectionalization(menu)
    Sectionalization.where(:section_id => self.id).where(:menu_id => menu.id).first
  end
end
