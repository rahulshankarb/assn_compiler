class UsersController < ApplicationController
before_filter :require_login, :only => [:destroy, :edit]
respond_to :html, :json, :js


  # GET /users
  # GET /users.json
  def index
    @users = User.active.order("username").page(params[:page]).per(10)
    respond_with(@users)

  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_with(@user)
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.active = true

    flash[:success] = "User was successfully created." if @user.save
    respond_with(@user)
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    flash[:success] = "User was successfully updated." if @user.update_attributes(params[:user])
    respond_with(@user)

  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.active = false;
    @user.save;

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
