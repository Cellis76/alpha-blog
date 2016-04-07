class ArticlesController < ApplicationController
  
  def index
    @articles = Article.all # can call this whatever you want @anythingyouwant
  end
  
  def new
    @article = Article.new
  end
  
  def edit
    @article = Article.find(params[:id]) # Need to find article using id first
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
  
  def update
    @article = Article.find(params[:id])
      if @article.update(article_params) # Need to whitelist whatever has been submitted.
        flash[:notice] = "Article was successfully updated"
        redirect_to article_path(@article)
      else
        render 'edit' # renders 'edit' template
      end
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article was successfully deleted"
    redirect_to articles_path
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
