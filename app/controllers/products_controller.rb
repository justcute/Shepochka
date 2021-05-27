class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  before_action :initialize_session
  before_action :load_cart

  def initialize_session
    if user_signed_in?
      session[:cart]||=[]
    end
  end

  def add_to_cart
    id = params[:id].to_i

    session[:cart] << id unless session[:cart].include?(id)
    redirect_to products_path
  end

  def remove_from_cart
    session[:cart].delete(params[:id].to_i)
    redirect_to products_path
  end

  def load_cart
    if user_signed_in?
      @cart=Product.find(session[:cart])
    end
  end
  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    authorize @product
  end

  # GET /products/1/edit
  def edit
    authorize @product
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params_update)
        @product.rating = @product.parameter1+@product.parameter2+@product.parameter3+@product.parameter4+@product.parameter5
        @product.rating/=5
        @product.save
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /products/1 or /products/1.json
  def destroy
    authorize @product
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :body, :avatar)
    end

    def product_params_update
      params.require(:product).permit(:title, :body, :avatar, :parameter1, :parameter2,
      :parameter3, :parameter4, :parameter5)
    end
end
