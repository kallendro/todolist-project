require File.dirname(__FILE__) + '/../test_helper'

class ListsControllerTest < ActionController::TestCase
  test "index action should retrieve all lists" do
    Factory(:list)
    # Index action does exist in controller
    # Index view is present
    get :index

    # @lists == List.all
    assert_equal List.all, assigns(:lists)
  end

  test "new action should present a new form" do
    user = Factory(:user)
    get :new, :user_id => user
    assert_tag :tag => "form", :attributes => {:action => user_lists_path(user), :method => "post"}
    assert_tag :tag => "input", :attributes => {:id => "list_subject"}
    assert_tag :tag => "input", :attributes => {:value => "Create"}
  end

  test "create action should create new list and redirects to index page" do
    # should have a user
    user = Factory(:user)
    user_list_count = user.lists.size
    parameters = {:user_id => user.id, :list => { :subject => "Whatever lah" } }
    list_count = List.count
    # create action
    post :create, parameters
    # redirected to user show page
    assert_redirected_to user_path(user)
    # +1 user's list
    assert_equal list_count + 1, List.count
    user.reload
    assert_equal user_list_count + 1, user.lists.size
  end

  test "edit action should present an edit form" do
    user = Factory(:user)
    list = Factory(:list, :user => user)
    get :edit, :id => list
    assert_tag :tag => "form", :attributes => {:action => user_list_path(user, list), :method => "post"}
    assert_tag :tag => "input", :attributes => {:id => "list_subject"}
    assert_tag :tag => "input", :attributes => {:value => "Update"}
  end

  test "update action should update the list and redirects to list page" do
    list = Factory(:list)
    user = list.user
    parameters = {
      :id => list, 
      :list => {:subject => "lalalallaa"}
    }
    # update action
    post :update, parameters
    # redirected to index page
    assert_redirected_to user_path(user) 
    # attributes are updated
    list.reload
    assert_equal "lalalallaa", list.subject
  end

  test "show action should show the lists" do
    user = Factory(:user)
    list = Factory(:list, :user => user)
    (1..2).each do |n| 
      Factory(:todo, :list => list)
    end
    # show action
    get :show, :id => list, :list => list
    # @list should fetch the right record
    assert_equal list, assigns(:list)
    assert list.todos.size > 0
  end

  test "destroy action should destroy record" do
    list = Factory(:list)
    list_count = List.count
    # destroy action
    delete :destroy, :id =>list
    # redirected to index page
    assert_redirected_to user_path(list.user) 
    # record deleted
    # List.all - 1
    assert_equal list_count - 1, List.count
    #List.find(id) should throw ActiveRecord::RecordNotFound error
    assert_raise ActiveRecord::RecordNotFound do 
      List.find(list.id) 
    end
  end
end
