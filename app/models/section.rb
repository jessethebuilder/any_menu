class Section < ActiveRecord::Base
  has_many :sectionalizations
  has_many :menus, :through => :sectionalizations

  has_many :items
end
