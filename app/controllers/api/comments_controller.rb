class API::CommentsController < ApplicationController


    before_action :set_video, only: [:index, :create, :destroy]
    before_action :set_comment, only: [:destroy]

    def index
        render json: @video.comments, status: 200
    end

    def create
        @comment = @video.comments.build(comment_params)
        if @comment.save
            render json: @comment, status: 201
        else
            render_errors_in_json
        end
    end

    def destroy
        @comment.destroy
    end

    private

    def set_video
        @video = Video.find_by(id: params[:video_id])
        if !@video
            render json: {
                errors: {
                    messages: { video: "can't be found"}
                }
            }, status: 404
        end
    end

    def set_comment
        @comment = @video.comments.find_by(id: params[:id])
        if !@comment
            render json: {
                errors: {
                    messages: { comment: "can't be found"}
                }
            }, status: 404
        end
    end

    def render_errors_in_json
        render json: {
            errors: {
                messages:  @comment.errors.messages
            }
        }, status: 422
    end

    def comment_params # a key filled of comments
        params.require(:comment).permit(:content, :rating)
    end



end
