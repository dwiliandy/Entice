class CommentsController < ApplicationController
	before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :current_product, only: [:create]

  def index
    @comments = Comment.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)

      if @conversation.save
      	redirect_to comments_path, notice: 'Comment was successfully created.'
      else
        render 'new'
      end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comments_path, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_path, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def current_product
      @product = Product.find(params[:id])
      params.deep_merge!(comment:{product_id: @product.id})
    end

    def comment_params
      params.require(:comment).permit(:content, :user_id, :product_id).with_defaults(user_id: current_user.id)
    end
end
