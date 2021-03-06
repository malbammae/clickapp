class UsersController < ApplicationController
  layout 'login', :only => [:new, :create]
  skip_before_action :login_required, :only => [:new, :create]

  def index
    if request.format.json?
      return render json:User.pluck(:id, :name, :lastname, :role, :rut, :email).all()
    end
  end


  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def changePass
    @user = User.find(params[:id])
  end


  def new
    @user = User.new
  end

  def destroy
    user= User.find(params[:id])
    render json:{:status => user.destroy}
  end

  def create
    if [params[:user][:password]] == [params[:user][:confpassword]]
        @user = User.new(user_params)
        @user.institution = []
        @user.institution  << [params[:user][:institution]]

        if [params[:user][:role]] != 'student' || [params[:user][:role]] != 'teacher'
          @user.role = 'student'
        end

        if @user.save?
            log_in @user
            redirect_to root_path
        else render "new"
        end
    else
      @user = User.new
      flash.now[:notice] = "Algo sucedió, inténtalo de nuevo."
      render "new"
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render 'show' #flash?
    end
  end


  def changePassword
    @user = User.find(params[:id])
  end

  private


  def user_params
  params.require(:user).permit(:rut, :name, :lastname, :institution, :role, :email, :password).to_h
  #AGREGAR INSTITUTION
  end

end
