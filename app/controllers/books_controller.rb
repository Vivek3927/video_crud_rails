require 'net/http'
class BooksController < ApplicationController

  include CommonCrud

  def yt_videos
    response = RestClient.get('http://localhost:3001/videos')
    
    puts response
    @youtube_videos = JSON.parse(response.body)

    # uri = URI('http://localhost:3001/videos')
    # response = Net::HTTP.get(uri)

    # puts response 
    # @videos = JSON.parse(response)
  end

  def display_video
    uri = URI("http://localhost:3001/videos/#{params[:video_id]}")
    response = Net::HTTP.get(uri)
    puts response 
    @youtube_vides = JSON.parse(response)
  end

  private

    def book_params
      params.require(:book).permit!
    end
end
