require File.join(File.dirname(__FILE__), '..', 'test_helper')

class TodoTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  context "a valid todo" do
    should_validate_presence_of :subject
    should_belong_to :list
  end
end
