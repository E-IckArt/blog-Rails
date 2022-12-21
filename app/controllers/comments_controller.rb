class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET articles/:article_id/comments or articles/:article_id/comments.json
  def index
    @comments = Comment.all
    @article = Article.find(params[:article_id])
  end

  # GET articles/:article_id/comments/:id or articles/:article_id/comments/:id.json
  def show
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  # GET articles/:article_id/comments/new
  def new
  end

  # GET articles/:article_id/comments/:id/edit
  def edit
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  # POST articles/:article_id/comments or articles/:article_id/comments.json
  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.new(comment_params)
    # Instantiate a new Object with comment_params without link to @article.
    # comment_params contains :comment, :body and :article_id. This allows us to link a comment to its article when saving it in DB.

    if @comment.save
      redirect_to article_path(@article), notice: "Comment was successfully created."
    else
      render 'articles/show', status: :unprocessable_entity
    end
  end

  # PATCH/PUT articles/:article_id/comments/:id or articles/:article_id/comments/:id.json

  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to article_comments_path(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE articles/:article_id/comments/:id or articles/:article_id/comments/:id.json
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:comment, :body, :article_id, :status)
    end
end
