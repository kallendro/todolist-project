class Todo < ActiveRecord::Base
  validates_presence_of :subject
  belongs_to :list
end
