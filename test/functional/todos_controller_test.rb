require File.dirname(__FILE__) + '/../test_helper'

class TodosControllerTest < ActionController::TestCase
  test "index action should retrieve all todos" do
    # Index action does exist in controller
    # Index view is present
    list = Factory(:list)
    get :index, :list_id => list

    # @todos == Todo.all
    assert_equal Todo.all, assigns(:todos)
  end

  test "new action should present a new form" do
    list = Factory(:list)
    get :new, :list_id => list
    assert_tag :tag => "form", :attributes => {:action => list_todos_path(list), :method => "post"}
    assert_tag :tag => "input", :attributes => {:id => "todo_subject"}
    assert_tag :tag => "input", :attributes => {:value => "Create"}
  end

  test "create action should create new todo and redirects to parent list show page" do
    list = Factory(:list)
    parameters = { :list_id => list, :todo => { :subject => "Whatever lah" } }
    todo_count = Todo.count
    # create action
    post :create, parameters
    # redirected to index page
    assert_redirected_to list_path(list)
    # +1 todo
    assert_equal todo_count + 1, Todo.count
    # list.todos.size == 1
    assert_equal 1, list.todos.size
  end

  test "edit action should present an edit form" do
    todo = Factory(:todo)
    list = todo.list
    get :edit, :id => todo, :list_id => list
    assert_tag :tag => "form", :attributes => {:action => list_todo_path(list), :method => "post"}
    assert_tag :tag => "input", :attributes => {:id => "todo_subject"}
    assert_tag :tag => "input", :attributes => {:value => "Update"}
  end

  test "update action should update the todo and redirects to todo page" do
    todo = Factory(:todo)
    list = todo.list
    parameters = {
      :list_id => list,
      :id => todo, 
      :todo => {:subject => "lalalallaa"}
    }
    # update action
    post :update, parameters
    # redirected to index page
    assert_redirected_to list_path(list)
    # attributes are updated
    todo.reload
    assert_equal "lalalallaa", todo.subject
    assert_equal 1, list.todos.size
  end

  test "show action should show the todos" do
    todo = Factory(:todo)
    list = todo.list
    # show action
    get :show, :id => todo, :list_id => list
    # @todo should fetch the right record
    assert_equal todo, assigns(:todo)
  end

  test "destroy action should destroy record" do
    todo = Factory(:todo)
    list = todo.list
    todo_count = Todo.count
    # destroy action
    delete :destroy, :id =>todo, :list_id => list
    # redirected to index page
    assert_redirected_to list_path(list)
    # record deleted
    # Todo.all - 1
    assert_equal todo_count - 1, Todo.count
    #Todo.find(id) should throw ActiveRecord::RecordNotFound error
    assert_raise ActiveRecord::RecordNotFound do 
      Todo.find(todo.id) 
    end
  end
end
