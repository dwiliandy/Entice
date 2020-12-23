class Admins::ProductsController < AdminsController

    def index
        @products = Product.all
    end
end
