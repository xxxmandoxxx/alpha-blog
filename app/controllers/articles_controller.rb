class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def index
        @articles = Article.paginate(page: params[:page], per_page: 5).order('created_at DESC')
    end
    
    def show
    end
    
    def new
        require_user
        @article = Article.new
    end
    
    def edit
    end
    
    def create
        # render plain: params[:article].inspect
        @article = Article.new(article_params)
        
        @article.user = current_user
        
        if @article.save
            flash[:success] = "Article was succesfully create"
            redirect_to article_path(@article)
        else
            # flash[:danger] = @article.errors.full_messages 
            render 'new'
        end
        
    end
    
   
    def update
       if @article.update(article_params)
         flash[:success] = "Article was succesfully updated"
            redirect_to article_path(@article)
        else
            #flash[:error] = @article.errors.full_messages 
            render 'edit'
       end
    end
    
    def destroy
        if @article.destroy
            flash[:success] = "Article was succesfully deleted"
            redirect_to articles_path
        else
            flash[:danger] = "Error deleting article"
        end
    end
    
    
    private
        def article_params
            params.require(:article).permit(:title, :description)
        end
        
        def set_article
            @article = Article.find(params[:id])
        end
        
        def require_same_user
           if current_user != @article.user
               flash[:danger] = "You can only edit or delete your own articles."
               redirect_to root_path
           end
        end
end