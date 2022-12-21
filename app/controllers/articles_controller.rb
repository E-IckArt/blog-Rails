class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @comment = @article.comments.build
  end

  def new
    @article = Article.new(title: "", body: "")
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article #the browser will send a new request. Must be used after mutating the DB or application state
    else
      render :new, status: :unprocessable_entity # Renders the specified view for the current request
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, notice: "Post was successfully destroyed.", status: :see_other

  end

  private
  # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
