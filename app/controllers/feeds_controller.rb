
class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]


def sourceexport
    @feeds = Feed.all
    f=File.new('sources.txt', 'r+') 

     @feeds.each do |tt|
      f << [tt.id.to_s,tt.name,tt.ref,tt.created_at.to_s,tt.updated_at.to_s,tt.avatar_file_name,tt.avatar_content_type,tt.avatar_file_size.to_s,tt.avatar_updated_at.to_s, tt.count.to_s, tt.type,tt.html].join(';') <<"\n"
     #oa
     end
  end




def sourceimport
    #@tags = Tagecxept.new
   #csv_text = File.read('tags1.txt')
   csv = CSV.foreach('sources.txt', :headers => false)
   csv.each do |row|
   a=row.to_s.split(";")
   s1=a[0][2,a[0].length-2]
   source=Feed.find_by_id(s1)|| Feed.new
   source.name=a[1]
   source.url=a[2]
   source.created_at=a[3].to_datetime
   source.updated_at =a[4].to_datetime  
   source.icon_file_name=a[5]
   source.icon_content_type=a[6]
   source.icon_file_size=a[7].to_i
   source.icon_updated_at=a[8].to_datetime
   source.count=a[9].to_i
   source.type=a[10]
   source.html=a[11][0,a[11].length-2] 
   source.html="false" if source.html.nil?
   #lo
   source.save
   end
  end

  def index
    @feeds = Feed.all
  end

  def show
  end

  def new
    @feed = Feed.new
  end

  def edit
  end

  def create
    @feed = Feed.new(feed_params)

    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_feed
    @feed = Feed.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def feed_params
    params.require(:feed).permit!
  end
end
