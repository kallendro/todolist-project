class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def new
    @user = User.find(params[:user_id])
    @list = List.new
  end

  def create
    @user = User.find(params[:user_id])
    @list = List.new(params[:list])
    @list.user = @user
    if @list.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @list = List.find(params[:id]) 
    @user = @list.user
  end

  def update
    @list = List.find(params[:id])
    @list.attributes = params[:list]
    if @list.save
      redirect_to user_path(@list.user) 
    else
      render :edit
    end

  end

  def show 
    @list = List.find(params[:id])
    @user = @list.user
  end

  def destroy
    @list = List.find(params[:id])
    if @list.destroy
      redirect_to user_path(@list.user)
    end
  end

end
