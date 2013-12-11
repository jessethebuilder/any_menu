class Sectionalizatoin < ActiveRecord::Base
  belongs_to :menu
  belongs_to :section
end