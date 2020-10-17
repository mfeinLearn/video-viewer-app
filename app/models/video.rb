class Video < ApplicationRecord
    has_many :comments, dependent: :destroy
    ## we dont have the dependent relationship!
    ## since now we have this dependent relationship it means when
    ##.. we delete video all of the comments related to it will be
    ##.. deleted
    validates :youtube_video_id, :description, :title, presence: true
end
