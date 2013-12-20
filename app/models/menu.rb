class Menu < ActiveRecord::Base
  has_many :sectionalizations, :dependent => :destroy
  has_many :sections, :through => :sectionalizations

  belongs_to :store
  validates :store, :presence => true

  validates :name, :presence => true

  belongs_to :hours_available, :dependent => :destroy
  #validates :hours_available , :presence => true
  accepts_nested_attributes_for :hours_available

  def sections_not_on_this_menu
    s1 = Section.joins(:sectionalizations).where.not(:sectionalizations => {:menu_id => self.id})
    s2 = Section.joins('LEFT OUTER JOIN sectionalizations on sections.id = sectionalizations.section_id').where('sectionalizations.section_id IS NULL')
    s1 + s2
  end
end
