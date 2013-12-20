class Section < ActiveRecord::Base
  #attr_accessor :id_for_menu

  has_many :sectionalizations, :dependent => :destroy
  has_many :menus, :through => :sectionalizations

  has_many :items

  validates :name, :presence => true

  def sectionalization(menu)
    Sectionalization.where(:section_id => self.id).where(:menu_id => menu.id).first
  end

end
