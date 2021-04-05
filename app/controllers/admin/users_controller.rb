# frozen_string_literal: true

class Admin::UsersController < AdminController
  before_action :prepare_form_data, only: %i[new edit update]
  before_action :prepare_user, only: %i[edit update destroy update_password]

  def index
    authorize! :read, 'user'

    @users = User.eager_load(:role)
                 .search(params[:search])
                 .page(params[:page])
                 .per(25)
                 .order(name: :asc)

    @users = @users.where.not('roles.code = ?', 'superadmin') unless can?(:manage, 'system')
  end

  def new
    authorize! :create, 'user'

    @user = User.new
  end

  def create
    authorize! :create, 'user'
    ActiveRecord::Base.transaction do
      unless valid_password?
        flash[:error] = 'Passsword Confirmation not match'
        return redirect_back(fallback_location: admin_users_path)
      end

      @user = User.new user_params
      @user.type = 'UserAdmin'

      if @user.save!
        flash[:success] = 'Success Add New User'
      else
        flash[:error] = 'Failed to Add New User'
      end
    end
    redirect_to admin_users_path
  rescue StandardError => e
    flash[:error] = "Failed to Add New User. #{e.message}"
    redirect_to admin_users_path
  end

  def edit
    authorize! :update, 'user'
  end

  def update
    authorize! :update, 'user'

    success = false
    if user_params[:password].present? || user_params[:password_confirmation].present?
      unless valid_password?
        flash[:error] = 'Passsword Confirmation not match'
        return redirect_back(fallback_location: admin_users_path)
      end

      success = @user.update user_params
    else
      success = @user.update_without_password user_params
    end

    if success
      flash[:success] = 'Success Update User'
      redirect_to admin_users_path
    else
      flash[:error] = 'Failed to Update User'
      render :edit
    end
  end

  def destroy
    authorize! :delete, 'user'

    if @user.destroy!
      flash[:success] = 'Success Delete User'
    else
      flash[:error] = 'Failed Delete User'
    end
    redirect_to admin_users_path
  end

  def change_password; end

  def update_password
    unless valid_password?
      flash[:error] = 'Passsword Confirmation not match'
      return redirect_back(fallback_location: admin_path)
    end

    user = current_user
    unless user.valid_password?(user_params[:old_password])
      flash[:error] = 'Password Lama tidak Cocok'
      return redirect_back(fallback_location: admin_path)
    end

    user.password = user_params[:password]
    user.data['first_time'] = false
    user.save

    flash[:success] = 'Success Change Password'
    redirect_to admin_path
  end

  private

  def prepare_form_data
    @role_options = Role.options
  end

  def prepare_user
    @user = User.find params[:id]
  end

  def user_params
    params[:user].permit(:role_id, :name, :email, :password, :password_confirmation, :old_password)
  end

  def valid_password?
    password = user_params[:password]
    confirmation = user_params[:password_confirmation]

    password == confirmation
  end
end
