class User < ActiveRecord::Base
  include ApplicationHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :user_type, :presence => true, :inclusion => { :in => USER_TYPES }
  DeviseController

  has_many :orders
end
