class ProductsController < ApplicationController
  before_action :verify_product, only: [:show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :verify_admin, only: [:new, :create, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    category = params[:category]
    if category == "" || category == nil
      @products = Product.where(active: true).order("created_at DESC").paginate(page: params[:page], per_page: 10)
    else
      @products = Product.where(category_id: category, active: true).order("created_at DESC").paginate(page: params[:page], per_page: 10)
    end

 
    if params[:search]
      @products = Product.where(active: true).search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 10)
    end

  end

  def push
    @products = Product.where(active: true, push: true).order("created_at DESC").paginate(page: params[:page], per_page: 10)
    render "index"
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.create( product_params )

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
params.require(:product).permit(:category_id, :title, :description, :qnt, :price, :active, :push, :image_url)
    end
end
