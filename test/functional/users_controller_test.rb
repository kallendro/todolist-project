require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase
  test "index action should retrieve all users" do
    User.create(:username => 'kallendro', :password => 'kallendro', :firstname => 'kelvin', :lastname => 'susetyo', :dob => '3-9-1986')
    # Index action does exist in controller
    # Index view is present
    get :index

    # @users == User.all
    assert_equal User.all, assigns(:users)
  end

  test "new action should present a new form" do
    get :new
    assert_tag :tag => "form", :attributes => {:action => "/users", :method => "post"}
    assert_tag :tag => "input", :attributes => {:id => "user_username"}
    assert_tag :tag => "input", :attributes => {:id => "user_password"}
    assert_tag :tag => "input", :attributes => {:id => "user_password_confirmation"}
    assert_tag :tag => "input", :attributes => {:id => "user_firstname"}
    assert_tag :tag => "input", :attributes => {:id => "user_lastname"}
    assert_tag :tag => "input", :attributes => {:id => "user_dob"}
    assert_tag :tag => "input", :attributes => {:value => "Create"}
  end

  test "create action should create new user and redirects to index page" do
    parameters = { :user => { 
      :username => "Whatever lah", 
      :password => "aaaa",
      :password_confirmation => "aaaa",
      :firstname => "aaa",
      :lastname => "aaa",
      :dob => "1-1-1999"
    } }
    user_count = User.count
    # create action
    post :create, parameters
    # redirected to index page
    assert_redirected_to users_path
    # +1 user
    assert_equal user_count + 1, User.count
  end

  test "edit action should present an edit form" do
    user = User.create(
      :username => "Whatever lah", 
      :password => "aaaa",
      :password_confirmation => "aaaa",
      :firstname => "aaa",
      :lastname => "aaa",
      :dob => "1-1-1999"
    )
    get :edit, :id => user
    assert_tag :tag => "form", :attributes => {:action => "/users/#{user.id}", :method => "post"}
    assert_tag :tag => "input", :attributes => {:id => "user_username"}
    assert_tag :tag => "input", :attributes => {:id => "user_firstname"}
    assert_tag :tag => "input", :attributes => {:id => "user_lastname"}
    assert_tag :tag => "input", :attributes => {:id => "user_dob"}
    assert_tag :tag => "input", :attributes => {:value => "Update"}
  end

  test "update action should update the user and redirects to user page" do
    user = User.create(
      :username => "Whatever lah", 
      :password => "aaaa",
      :password_confirmation => "aaaa",
      :firstname => "aaa",
      :lastname => "aaa",
      :dob => "1-1-1999"
    )
    parameters = {
      :id => user, 
      :user => {
        :username => "Whatever lah2", 
        :password => "aaaa2",
        :password_confirmation => "aaaa2",
        :firstname => "aaa2",
        :lastname => "aaa2",
        :dob => "2-1-1999"
      }
    }
    # update action
    post :update, parameters
    # redirected to index page
    assert_redirected_to users_path
    # attributes are updated
    user.reload
    assert_equal "Whatever lah2", user.username
    assert_equal "aaa2", user.firstname
    assert_equal "aaa2", user.lastname
    assert_equal "2-1-1999", user.dob
  end

  test "show action should show the users" do
    user = User.create(
      :username => "Whatever lah", 
      :password => "aaaa",
      :password_confirmation => "aaaa",
      :firstname => "aaa",
      :lastname => "aaa",
      :dob => "1-1-1999"
    )
    # show action
    get :show, :id => user, :user => user
    # @user should fetch the right record
    assert_equal user, assigns(:user)
  end

  test "destroy action should destroy record" do
    user = User.create(
      :username => "Whatever lah", 
      :password => "aaaa",
      :password_confirmation => "aaaa",
      :firstname => "aaa",
      :lastname => "aaa",
      :dob => "1-1-1999"
    )
    user_count = User.count
    # destroy action
    delete :destroy, :id =>user
    # redirected to index page
    assert_redirected_to users_path
    # record deleted
    # User.all - 1
    assert_equal user_count - 1, User.count
    #User.find(id) should throw ActiveRecord::RecordNotFound error
    assert_raise ActiveRecord::RecordNotFound do 
      User.find(user.id) 
    end
  end
end
