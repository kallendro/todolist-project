class User < ActiveRecord::Base
  validates_presence_of :username
  validates_presence_of :password
  validates_presence_of :firstname
  validates_presence_of :lastname
  validates_presence_of :dob
  validates_confirmation_of :password
  has_many :lists
end
