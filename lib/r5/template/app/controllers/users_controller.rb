class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :only_for_admin, except: [:edit_own_password, :update_password]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit

  end

  def edit_password
    @user = User.find(params[:id])
  end

  def edit_own_password
    @user = current_user
    render 'edit_password'
  end

  def update_password
    @user = User.find(params[:id])
    if @user.id == current_user.id
      if @user.update_with_password(user_params)
        sign_in @user, :bypass => true
        redirect_to root_path
      else
        render 'edit_password'
      end
    else
      if @user.update(user_params)
        redirect_to root_path
      else
        render 'edit_password'
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'Uživatel byl uložen.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'Uživatel byl upraven.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Uživatel byl odstraněn.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end



  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.required(:user).permit(:password, :password_confirmation, :current_password, :email,
                                  :login, :firstname, :lastname)
  end
end
