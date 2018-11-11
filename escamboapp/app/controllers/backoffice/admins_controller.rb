class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only:[:edit, :update, :destroy]

  def index
    #@admins = Admin.all
    #@admins = Admin.with_full_acess
    @admins = policy_scope(Admin)

  end

  def new
    @admin = Admin.new
    authorize @admin
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to backoffice_admins_path, notice: "The admin (#{@admin.email}) its succeful cadastred"
    else
      render :new
    end
  end

  def edit
  end

  def update
    passwd = params[:admin][:password]
    passwd_confirmation = params[:admin][:password_confirmation]

    if passwd.blank? && passwd_confirmation.blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    if  @admin.update(params_admin)
      AdminMailer.update_email(current_admin, @admin).deliver_now
      redirect_to backoffice_admins_path, notice: "The admin (#{@admin.email}) its succeful update"
    else
      render :edit
    end
  end

  def destroy
    admin_email = @admin.email
    if  @admin.destroy
      redirect_to backoffice_admins_path, notice: "The admin (#{admin_email}) its succeful deleted"
    else
      render :index
    end
  end

  private

  def params_admin
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end
end
