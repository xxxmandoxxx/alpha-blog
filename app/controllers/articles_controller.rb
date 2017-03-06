class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    
    def index
        @articles = Article.all.reverse
    end
    
    def show
    end
    
    def new
        @article = Article.new
    end
    
    def edit
    end
    
    def create
        # render plain: params[:article].inspect
        @article = Article.new(article_params)
        
        #remeber to change this
        @article.user = User.last
        #------
        
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
end