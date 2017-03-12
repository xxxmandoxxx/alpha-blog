class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def index
      @users = User.paginate(page: params[:page], per_page: 5)
    end
    
    def new
        @user = User.new
    end
    
    def create
       @user = User.new(user_params) 
       if @user.save
           session[:user_id] = @user.id
           flash[:success] = "Hello #{@user.username}! You have succesfully signed up"
           redirect_to articles_path
       else
           render 'new'
       end
    end
    
    def edit
    
    end
    
    def show
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 5).order('created_at DESC')
    end
    
    def update
        if @user.update(user_params)
            flash[:success] = "Profile has been succesfully updated"
            redirect_to articles_path
        else
            render 'edit'
        end
    end
    
    def destroy
       if @user.destroy
           flash[:success] = "User has been succesfully deleted"
           redirect_to users_path
       end
    end
    
    
    private
        def user_params
            params.require(:user).permit(:username, :email, :password)
        end
        
        def set_user
            @user = User.find(params[:id])
        end  
        
        def require_same_user
          if current_user != @user and !current_user.admin?
             flash[:danger] = "You can only edit your own account"
             redirect_to root_path
          end
        end
end