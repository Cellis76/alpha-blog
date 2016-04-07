class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
  
  def create
    # render plain: params[:article].inspect
    # Can't directly save what is being passed in from the params hash
    # Need to whitelist it first hence the params
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article) # redirect to articles path and it will show article
    else
      render 'new'
    end
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
