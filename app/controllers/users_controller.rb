class UsersController < ApplicationController

  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
   @user.birthdate ={}
    @user.birthdate[:year]= params[:@user].to_hash()["birthdate(1i)"]
    @user.birthdate[:month]=params[:@user].to_hash()["birthdate(2i)"]
    @user.birthdate[:day]=params[:@user].to_hash()["birthdate(3i)"]
    puts "BIRTHDAY"
    puts @user.birthdate
    if @user.save
      flash[:success] = "Welcome to the FamilyQuilt!"
      sign_in @user
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end


end
