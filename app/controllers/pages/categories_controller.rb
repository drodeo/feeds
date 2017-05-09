class Pages::CategoriesController < ApplicationController

  def index
    @pages = Page.where('category_id' => params['category_id']).order('published DESC').page(params[:page])
    #lo
    render 'pages/index'
  end


end
