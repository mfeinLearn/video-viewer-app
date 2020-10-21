require 'rails_helper'

RSpec.describe 'Videos API', type: :request do

    # Initial Test Data
    let!(:videos) { FactoryGirl.create_list(:video, 5) }
    let(:video_id) { videos.first.id }

    #GET /api/videos
    #  Returns Collection Of Videos
    describe 'GET /api/videos' do

        before { get '/api/videos' }

        it 'return a status code of 200' do
            expect(response).to have_http_status(200)
        end

        it 'returns a collection of videos in JSON' do
            #json = JSON.parse(response.body)

            expect(json).not_to be_empty
            expect(json.size).to eq(5)
        end
    end
    # 200 - found the resource and you are returning it with succcess.
    # 201,4 - signifies that you created a resource!

    #POST /api/videos
    #  Creates A Video And Returns New Video
    describe 'POST /api/videos' do
        context "when the request is valid" do

            let(:valid_attributes) {
                {
                    video: {
                        title: Faker::Lorem.word ,
                        description: Faker::Lorem.paragraph ,
                        youtube_video_id: Faker::Crypto.md5
                    }
                }
            }

            before { post '/api/videos', params: valid_attributes }

            it "return a status of code 201" do
                expect(response).to have_http_status(201)
            end
            it "created a video and returns it in JSON" do
                #json = JSON.parse(response.body, symbolize_names: true)

                expect(json).not_to be_empty
                expect(json[:id]).not_to eq(nil)
                expect(json[:title]).to eq(valid_attributes[:video][:title])
                expect(json[:description]).to eq(valid_attributes[:video][:description])
                expect(json[:youtube_video_id]).to eq(valid_attributes[:video][:youtube_video_id])
            end
        end
        context "when the request in invalid" do

            before { post '/api/videos', params: {
                video: {
                    title: '' ,
                    description: '' ,
                    youtube_video_id: ''
                }
                } }
            it "returns a status code of 422" do
                expect(response).to have_http_status(422) # if you dont define what you are returning you get a 204 as a response
            end
            it "returns the validation error messages in JSON" do
                #json = JSON.parse(response.body, symbolize_names: true)

                expect(json).not_to be_empty
                expect(json[:errors][:messages]).to eq({
                    :youtube_video_id=>["can't be blank"],
                    :description=>["can't be blank"],
                    :title=>["can't be blank"]
                })
            end
        end
    end

    #GET /api/videos/:id
    #  Returns a Video
    describe 'GET /api/videos/:id' do

        context "if video exist" do

            before { get "/api/videos/#{video_id}" }

            it 'return a status code of 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns a video in JSON' do
                #json = JSON.parse(response.body, symbolize_names: true)
                expect(json).not_to be_empty
                expect(json[:id]).to eq(video_id)
                expect(json[:title]).to eq(videos.first.title)
                expect(json[:description]).to eq(videos.first.description)
                expect(json[:youtube_video_id]).to eq(videos.first.youtube_video_id)
            end
        end

        context "if video does not exist" do
            before { get "/api/videos/1000" }

            it 'return a status code of 404' do
                expect(response).to have_http_status(404)
            end

            it "returns error messages of not found in JSON" do
                #json = JSON.parse(response.body, symbolize_names: true)

                expect(json).not_to be_empty
                expect(json[:errors][:messages]).to eq({:video=>"can't be found"})
            end
        end
    end


    #PUT /api/videos/:id
    #  Updates and Returns The Video Matching The Parameters ID
    describe 'PUT /api/videos/:id' do

        describe "if video exists" do

            context "and has valid params" do

                let(:valid_params) {
                    {
                        video: {
                            title: "Updated Title" ,
                            description: "Updated Description" ,
                            youtube_video_id: "abc123def"
                        }
                    }
                }


                #before { request to api }
                before { put "/api/videos/#{video_id}", params: valid_params }

                it 'updates the video' do
                    # access to response in the do block
                    expect(json[:title]).to eq(valid_params[:video][:title])
                    expect(json[:description]).to eq(valid_params[:video][:description])
                    expect(json[:youtube_video_id]).to eq(valid_params[:video][:youtube_video_id])
                end

                it 'returns a status code of 200' do #=> 200 when I want to return a resource
                    expect(response).to have_http_status(200)
                end
            end

            context "and has invalid params" do

                let(:invalid_params) {
                    {
                        video: {
                            title: "" ,
                            description: "" ,
                            youtube_video_id: ""
                        }
                    }
                }


                #before { request to api }
                before { put "/api/videos/#{video_id}", params: invalid_params }

                it "returns a status code of 422" do
                    expect(response).to have_http_status(422) # if you dont define what you are returning you get a 204 as a response
                end
                it "returns the validation error messages in JSON" do
                    #json = JSON.parse(response.body, symbolize_names: true)

                    expect(json).not_to be_empty
                    expect(json[:errors][:messages]).to eq({
                        :youtube_video_id=>["can't be blank"],
                        :description=>["can't be blank"],
                        :title=>["can't be blank"]
                    })
                end
            end
        end

        context "if video is not found" do

            before { put "/api/videos/10000" }

            it 'returns a status code of 404' do
                expect(response).to have_http_status(404)
            end

            it "returns error messages of not found in JSON" do
                #json = JSON.parse(response.body, symbolize_names: true)

                expect(json).not_to be_empty
                expect(json[:errors][:messages]).to eq({:video=>"can't be found"})
            end

        end
    end

    #DELETE /api/videos/:id
    #  Destroys The Video Matching The Parameters ID
    describe 'DELETE /api/videos/:id' do

        context "if video exists" do

            before { delete "/api/videos/#{video_id}" }

            it 'returns a status code 204' do
                expect(response).to have_http_status(204)
            end
        end

        context "if video is not found" do

            before { delete "/api/videos/10000" }

            it 'returns a status code of 404' do
                expect(response).to have_http_status(404)
            end

            it "returns error messages of not found in JSON" do
                #json = JSON.parse(response.body, symbolize_names: true)

                expect(json).not_to be_empty
                expect(json[:errors][:messages]).to eq({:video=>"can't be found"})
            end

        end

    end

end
# notes:

# status -
# 201 for creation

# response looks something like this - (an object of data back)
### response.body is this below ---VVV
# {
#     "id" : 1,
#     "title": "Test Title",
#     "description": "Test Description",
#     "youtube_video_id" : "abc123",
#     "created_at": "2020-01-17T20:37:17.984z"
#     "updated_at": "2020-01-17T20:37:17.984z"
# }
