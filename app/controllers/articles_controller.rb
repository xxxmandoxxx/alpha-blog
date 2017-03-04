class ArticlesController < ApplicationController
    
    def index
        @articles = Article.all
    end
    
    def show
        @article = Article.find(params[:id])
    end
    
    def new
        @article = Article.new
    end
    
    def edit
        @article = Article.find(params[:id])
    end
    
    def create
        # render plain: params[:article].inspect
        @article = Article.new(article_params)
        if @article.save
            flash[:notice] = "Article was succesfully create"
            redirect_to article_path(@article)
        else
            #flash[:error] = @article.errors.full_messages 
            render 'new'
        end
        
    end
    
   
    def update
   
       @article = Article.find(params[:id])
       if @article.update(article_params)
         flash[:notice] = "Article was succesfully updated"
            redirect_to article_path(@article)
        else
            #flash[:error] = @article.errors.full_messages 
            render 'edit'
       end
    end
    
    def destroy
        @article = Article.find(params[:id])
        if @article.destroy
            flash[:notice] = "Article was succesfully deleted"
            redirect_to articles_path
        else
            flash[:notice] = "Error deleting article"
        end
    end
    
    
    private
        def article_params
            params.require(:article).permit(:title, :description)
        end
    
    
end