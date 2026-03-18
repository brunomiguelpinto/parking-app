module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:edit, :update, :toggle]

    def index
      @users = User.order(:name)
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: "Utilizador criado."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      user_attrs = user_params
      user_attrs = user_attrs.except(:password, :password_confirmation) if user_attrs[:password].blank?
      if @user.update(user_attrs)
        redirect_to admin_users_path, notice: "Utilizador atualizado."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def toggle
      @user.update!(active: !@user.active)
      redirect_to admin_users_path, notice: "Utilizador #{@user.active? ? 'ativado' : 'desativado'}."
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end
  end
end
