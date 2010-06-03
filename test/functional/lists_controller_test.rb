require File.dirname(__FILE__) + '/../test_helper'

class ListsControllerTest < ActionController::TestCase
  test "index action should retrieve all lists" do
    # Index action does exist in controller
    # Index view is present
    get :index

    # @lists == List.all
    assert_equal List.all, assigns(:lists)
  end

  test "new action should present a new form" do
    get :new
    assert_tag :tag => "form", :attributes => {:action => "/lists", :method => "post"}
    assert_tag :tag => "input", :attributes => {:id => "list_subject"}
    assert_tag :tag => "input", :attributes => {:value => "Create"}
  end

  test "create action should create new list and redirects to index page" do
    parameters = { :list => { :subject => "Whatever lah" } }
    list_count = List.count
    # create action
    post :create, parameters
    # redirected to index page
    assert_redirected_to lists_path
    # +1 list
    assert_equal list_count + 1, List.count
  end

  test "edit action should present an edit form" do
    list = List.create(:subject => "hahaha")
    get :edit, :id => list
    assert_tag :tag => "form", :attributes => {:action => "/lists/#{list.id}", :method => "post"}
    assert_tag :tag => "input", :attributes => {:id => "list_subject"}
    assert_tag :tag => "input", :attributes => {:value => "Update"}
  end

  test "update action should update the list and redirects to list page" do
    list = List.create(:subject => "initial value")
    parameters = {
      :id => list, 
      :list => {:subject => "lalalallaa"}
    }
    # update action
    post :update, parameters
    # redirected to index page
    assert_redirected_to lists_path
    # attributes are updated
    list.reload
    assert_equal "lalalallaa", list.subject
  end

  test "show action should show the lists" do
    list = List.create(:subject => "hallo")
    (1..2).each do |n| 
      Todo.create(:subject => n.to_s, :list => list) 
    end
    # show action
    get :show, :id => list, :list => list
    # @list should fetch the right record
    assert_equal list, assigns(:list)
  end

  test "destroy action should destroy record" do
    list = List.create(:subject => "delete me")
    list_count = List.count
    # destroy action
    delete :destroy, :id =>list
    # redirected to index page
    assert_redirected_to lists_path
    # record deleted
    # List.all - 1
    assert_equal list_count - 1, List.count
    #List.find(id) should throw ActiveRecord::RecordNotFound error
    assert_raise ActiveRecord::RecordNotFound do 
      List.find(list.id) 
    end
  end
end
