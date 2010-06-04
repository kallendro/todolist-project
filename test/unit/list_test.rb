require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ListTest < ActiveSupport::TestCase
  context "A valid List" do
    should_validate_presence_of :subject
    should_have_many :todos
    should_belong_to :user
    # a list has  0 to M todos
    
     
  end
end
