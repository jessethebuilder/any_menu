class Menu < ActiveRecord::Base
  #add, move, remove ########################################################
  serialize :section_order, Array
  has_many :sectionalizations, :dependent => :destroy
  has_many :sections, :through => :sectionalizations, :after_add => :add_to_section_order,
           :after_remove => :remove_from_section_order

  def add_to_section_order(section)
    section_order = read_attribute(:section_order)
    section_order << section.id
    self.update(:section_order => section_order)
  end

  def remove_from_section_order(section)
    section_order = read_attribute(:section_order)
    section_order.delete(section.id)
    self.update(:section_order => section_order)
  end

  def move_section(section, velocity)
    section_order = read_attribute(:section_order)
    from_index = section_order.index(section.id)
    section_order.move!(from_index, from_index + Integer(velocity))
    self.update(:section_order => section_order)
  end

  def ordered_sections
    query = sections
    arr = []
    section_order.each do |s|
      arr << query.where(:id => s).first
    end
    arr
  end
  #add, move, remove ########################################################

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
