class Pages::CategoriesController < ApplicationController

  def index
    @channs=Chann.where(user_id: current_user.id) if current_user
    @categories = Category.order(pages_count: :desc).limit(15)
    @feeds = Feed.order(pages_count: :desc).limit(15)
    @pages = Page.where('category_id' => params['category_id']).order('published DESC').page(params[:page])
    render  'pages/index', locals: {pages: @pages}
  end


end
