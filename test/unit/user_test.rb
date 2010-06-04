require File.join(File.dirname(__FILE__), '..', 'test_helper')
 
class UserTest < ActiveSupport::TestCase
  context "A valid User" do 

    should_validate_presence_of :username
    should_validate_presence_of :password
    should_validate_presence_of :firstname
    should_validate_presence_of :lastname
    should_validate_presence_of :dob
    should_have_many :lists
    setup { @user = User.new(:username => 'a', :firstname => 'a', :lastname => 'a', :dob => 'a') }
    subject { @user }

    should "validate confirmation of password" do
      @user.password_confirmation = nil
      assert !@user.save

      @user.password = "aaa"
      @user.password_confirmation = "bbb"
      assert !@user.save

      @user.password_confirmation = "aaa"
      assert @user.save
    end
  end
end
