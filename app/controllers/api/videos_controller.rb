class API::VideosController < ApplicationController
## this will return a collection of videos
## and this will seralize those into a collection of videos
def index
    videos = Video.all
    render json: videos, status: 200
end

def create
    video = Video.new(video_params)
    if video.save
        render json: video, status: 201
    end
end

private

def video_params
    params.require(:video).permit(:title, :description, :youtube_video_id)
end


end
