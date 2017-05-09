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
    @pages = Page.where('feed_id' => params['feed_id']).order('published DESC').page(params[:page])
    render 'pages/index'
  end


end
