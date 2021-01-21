class ConversationsController < ApplicationController
	before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  before_action :current_product, only: [:create]

  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = Conversation.all.order(created_at: :desc)
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)

      if @conversation.save
      	redirect_to conversations_path, notice: 'Conversation was successfully created.'
      else
        render 'new'
      end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to conversations_path, notice: 'conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_path, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    def current_product
      @product = Product.find(params[:id])
      params.deep_merge!(conversation:{product_id: @product.id})
    end

    # Only allow a list of trusted parameters through.
    def conversation_params
      params.require(:conversation).permit(:content, :user_id, :product_id).with_defaults(user_id: current_user.id)
    end
end