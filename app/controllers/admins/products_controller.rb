class Admins::ProductsController < AdminsController

  before_action :set_product, only: [:show, :edit, :update, :destroy, :create_comment]

    def index
      @q = Product.order(created_at: :desc).ransack(params[:q])
		  @pagy, @products = pagy(@q.result(distinct: true), items:20)
    end

    def show
      @comments = Comment.where(product: @product).order(created_at: :desc)
    end

    
    def new
      @product = Product.new
    end

    
    def edit
    end

    
    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to admins_products_path, notice: "Product #{@product.name} was successfully created."
      else
        render 'new'
      end
    end


    def update
      if @product.update(product_params)
        redirect_to admins_products_path, notice: "Product #{@product.name} was successfully updated."
      else
        render 'edit'
      end
    end


def destroy
  @product.destroy
  respond_to do |format|
    format.html { redirect_to admins_products_path, notice: "Product was successfully destroyed." }
    format.json { head :no_content }
  end
end

  def create_comment
    
    if params[:content][:message].present?
      Comment.create(content: params[:content][:message], user: current_user, product: @product)
      redirect_to product_path(@product), notice: "Comment has been posted"
    else
      redirect_to admins_product_path(@product)
    end
  end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
        @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
        params.require(:product).permit(:name, :price, :image, :stock, :status, :region_id, :description)
    end

end
