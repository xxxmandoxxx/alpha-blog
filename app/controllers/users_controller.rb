class UsersController < ApplicationController
    before_action :get_user, only: [:edit, :update, :destroy, :show]
    
    def new
        @user = User.new
    end
    
    def create
       @user = User.new(user_params) 
       if @user.save
           flash[:success] = "Hello #{@user.username}! You have succesfully signed up"
           redirect_to articles_path
       else
           render 'new'
       end
    end
    
    def edit
    
    end
    
    def show
        
    end
    
    def update
        if @user.update(user_params)
            flash[:success] = "Profile has been succesfully updated"
            redirect_to articles_path
        else
            render 'edit'
        end
    end
    
    
    private
        def user_params
            params.require(:user).permit(:username, :email, :password)
        end
        
        def get_user
            @user = User.find(params[:id])
        end  
end