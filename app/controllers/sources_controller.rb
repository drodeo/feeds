
class SourcesController < ApplicationController
  #before_action :set_source, only: [:show, :edit, :update, :destroy]


def sourceexport
    @sources = Feed.all
    f=File.new('sources.txt', 'r+') 

     @sources.each do |tt|
      f << [tt.id.to_s,tt.name,tt.url,tt.created_at.to_s,tt.updated_at.to_s,tt.icon_file_name,tt.icon_content_type,tt.icon_file_size.to_s,tt.icon_updated_at.to_s, tt.count.to_s, tt.type,tt.html].join(';') <<"\n"
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

 
end
