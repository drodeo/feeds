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
    @channs=Chann.where(user_id: current_user.id) if current_user
    if current_user
      Chann.where(user_id: User.current.id).each do |s|
        @pages.scope s.slug.to_sym, -> {where feed_id: s.feed_ids.split(',') }
      end
    end
    render 'pages/index'
  end


end
