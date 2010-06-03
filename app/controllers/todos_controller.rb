class TodosController < ApplicationController
  def index
    @list = List.find(params[:list_id])
    @todos = Todo.all
  end

  def new
    @list = List.find(params[:list_id])
    @todo = Todo.new
  end

  def create
    @list = List.find(params[:list_id])
    @todo = Todo.new(params[:todo])
    @todo.list = @list
    if @todo.save
      redirect_to list_path(@list) 
    else
      render :new
    end
  end

  def edit
    @list = List.find(params[:list_id])
    @todo = Todo.find(params[:id]) 
  end

  def update
    @list = List.find(params[:list_id])
    @todo = Todo.find(params[:id])
    @todo.attributes = params[:todo]
    if @todo.save
      redirect_to list_path(@list) 
    else
      render :edit
    end

  end

  def show 
    @todo = Todo.find(params[:id])
    @list = @todo.list
  end

  def destroy
    @list = List.find(params[:list_id])
    @todo = Todo.find(params[:id])
    if @todo.destroy
      redirect_to list_path(@list)
    end
  end

end
