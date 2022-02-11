# frozen_string_literal: true

class Admin::RolesController < AdminController
  before_action :prepare_role, only: %i[show edit update destroy]

  def index
    authorize! :read, 'role'

    @roles = Role.search(params[:search])
                 .where.not(code: 'superadmin')
                 .page(params[:page])
                 .order(name: :asc)
  end

  def show
    authorize! :read, 'role'
  end

  def new
    authorize! :create, 'role'
    @role = Role.new
    prepare_permissions
    prepare_role_abilities
  end

  def create
    authorize! :create, 'role'
    @role = Role.new role_params

    if @role.save
      flash[:success] = 'Successfully create new role.'
      redirect_to admin_roles_path
    else
      prepare_permissions
      prepare_role_abilities
      flash[:error] = 'Failed to create role.'
      render :new
    end
  end

  def edit
    authorize! :update, 'role'
    prepare_permissions
    prepare_role_abilities
  end

  def update
    authorize! :update, 'role'
    if @role.update role_params
      flash[:success] = 'Role has successfully updated.'
      redirect_to admin_role_path(@role)
    else
      prepare_permissions
      prepare_role_abilities
      flash[:error] = 'Failed to update role.'
      render :edit
    end
  end

  def destroy
    authorize! :delete, 'role'
    if @role.destroy
      flash[:success] = 'Role has successfully removed.'
    else
      flash[:error] = 'Failed to remove role.'
    end

    redirect_to admin_roles_path
  end

  private

  def prepare_role
    @role = Role.find(params[:id])
  end

  def prepare_permissions
    @permissions = Permission.all.group_by(&:module_name)
  end

  def prepare_role_abilities
    role_abilities = @role.role_abilities
    @permissions.each do |_module_name, permissions|
      permissions.each do |permission|
        unless role_abilities.detect { |ab| ab.permission_id == permission.id }
          @role.role_abilities.build(permission_id: permission.id)
        end
      end
    end
  end

  def role_params
    params[:role].permit(
      :type, :code, :name,
      role_abilities_attributes: %i[id permission_id _destroy]
    )
  end
end
