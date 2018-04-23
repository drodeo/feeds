# == Schema Information
#
# Table name: sources
#
#  id                  :integer          not null, primary key
#  name                :string
#  ref                 :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

class Pages::FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]



  def index
    @channs=Chann.where(user_id: current_user.id) if current_user
    @categories = Category.order(pages_count: :desc).limit(15)
    @feeds = Feed.order(pages_count: :desc).limit(15)
    @pages = Page.where('feed_id' => params['feed_id']).order('published DESC').page(params[:page])
    render  'pages/_index_form', locals: {pages: @pages}
  end


end
