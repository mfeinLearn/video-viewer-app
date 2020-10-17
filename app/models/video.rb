class Video < ApplicationRecord
    validates :youtube_video_id, :description, :title, presence: true
end
