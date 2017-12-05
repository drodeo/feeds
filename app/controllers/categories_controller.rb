
class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.order("pages_count DESC").page(params[:page])
  end

  def show
  end

  def count_categories
    #//       cat.children.each do |c|
    #//  cat.count += c.count
    #//end
    #//cat.save

    @cats=Category.pluck(:id)
    @cats.each do |cat|
      Category.reset_counters(cat, :pages)
    end
    cat1=Category.exists?('Без категории')
    @nocat=Page.where(category_id: nil)
    @nocat.update_all category_id: cat1.id
    Category.reset_counters(cat1.id, :pages)
  end

  # GET /categories/new
  def new
    @category = Category.new
    @list=Category.pluck(:name,:id)
  end

  # GET /categories/1/edit
  def edit
    @list=Category.pluck(:name,:id)
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    category=Category.find(params[:category][:parent_id])
    @category.children<<category

    respond_to do |format|
     # binding.pry
      #lo
      if @category.update( category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.fetch(:category, {})
      params.require(:category).permit(:name, :standard)
      #category_params.merge(parent: params[:parent].to_i)
    end
end
