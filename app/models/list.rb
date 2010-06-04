class List < ActiveRecord::Base
   validates_presence_of :subject
   has_many :todos
   belongs_to :user
end
