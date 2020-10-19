require 'rails_helper'

RSpec.describe 'Videos API', type: :request do

    # Initial Test Data
    let!(:videos) { FactoryGirl.create_list(:video, 5) }

    #GET /api/videos
    #  Returns Collection Of Videos
    describe 'GET /api/videos' do

        before { get '/api/videos' }

        it 'return a status code of 200' do
            expect(response).to have_http_status(200)
        end

        it 'returns a collection of videos in JSON' do
            json = JSON.parse(response.body)

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
                json = JSON.parse(response.body, symbolize_names: true)

                expect(json).not_to be_empty
                expect(json[:id]).not_to eq(nil)
                expect(json[:title]).to eq(valid_attributes[:video][:title])
                expect(json[:description]).to eq(valid_attributes[:video][:description])
                expect(json[:youtube_video_id]).to eq(valid_attributes[:video][:youtube_video_id])
            end
        end
        context "when the request in invalid"
    end

    #GET /api/video/:id
    #  Returns A Video And Returns New Video
    #PUT /api/videos/:id
    #  Updates and Returns The Video Matching The Parameters ID
    #DELETE /api/videos/:id
    #  Destroys The Video Matching The Parameters ID

end
