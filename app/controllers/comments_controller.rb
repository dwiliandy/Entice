class CommentsController < ApplicationController
	before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :current_product, only: [:create]

  # GET /conversations
  # GET /conversations.json
  def index
    @comments = Comment.all.order(created_at: :desc)
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
  end

  # GET /conversations/new
  def new
    @comment = Comment.new
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @comment = Comment.new(comment_params)

      if @conversation.save
      	redirect_to comments_path, notice: 'Comment was successfully created.'
      else
        render 'new'
      end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
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

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_path, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def current_product
      @product = Product.find(params[:id])
      params.deep_merge!(comment:{product_id: @product.id})
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :product_id).with_defaults(user_id: current_user.id)
    end
end
