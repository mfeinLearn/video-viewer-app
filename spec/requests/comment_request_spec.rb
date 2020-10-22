require 'rails_helper'

RSpec.describe 'Comments API', type: :request do

# Initial Test Data
let!(:video) { FactoryGirl.create(:video) }
let!(:comments) { FactoryGirl.create_list(:comment, 5, video_id: video.id) }
let(:video_id) {video.id}
let(:comment_id) { comments.first.id }

# GET /api/videos/:video_id/comments
describe 'GET /api/videos/:video_id/comments' do

        context "if video exists" do

            before(:each) {
                FactoryGirl.create(:comment)
            }

            before { get "/api/videos/#{video_id}/comments" }

            it "returns a status code of 200" do
                expect(response).to have_http_status(200)
            end
            it "returns all of the video's comments in JSON" do
                expect(json.size).to eq(5)
                expect(json[0][:id]).not_to eq(nil)
            end
        end

        context "if video is not found" do

            before { get "/api/videos/10000/comments" }

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

    # POST /api/videos/:video_id/comments
    describe 'POST /api/videos/:video_id/comments' do

        describe "if video exists" do

            context 'if params are valid' do

                let(:valid_params) {
                    {
                        comment: {
                            content: Faker::Lorem.paragraph ,
                            rating: 3
                        }
                    }
                }

                before { post "/api/videos/#{video_id}/comments", params: valid_params }

                it "returns a status code of 201" do
                    expect(response).to have_http_status(201)
                end
                it "returns all of the video's comments in JSON" do
                    expect(json).not_to be_empty
                    expect(json[:id]).not_to eq(nil)
                    expect(json[:content]).not_to eq(nil)
                    expect(json[:rating]).not_to eq(nil)
                end
            end

            context 'if params are invalid' do

                let(:invalid_params) {
                    {
                        comment: {
                            content: "" ,
                            rating: 6
                        }
                    }
                }

                before { post "/api/videos/#{video_id}/comments", params: invalid_params }

                it 'returns a status code of 422' do
                    expect(response).to have_http_status(422)
                end

                it "returns the validation error messages in JSON" do
                    #json = JSON.parse(response.body, symbolize_names: true)

                    expect(json).not_to be_empty
                    expect(json[:errors][:messages]).to eq({
                        :content=>["can't be blank"],
                        :rating=>["is not included in the list"]
                    })
                end
            end
        end

        context "if video is not found" do

            before { post "/api/videos/10000/comments" }

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

    # DELETE /api/videos/:video_id/comments/:id
    describe 'DELETE /api/videos/:video_id/comments/:id' do

        context "if video exists" do

            context "and comment exists" do

                before { delete "/api/videos/#{video_id}/comments/#{comment_id}" }

                it "returns a status code of 204" do
                    expect(response).to have_http_status(204)
                end
            end

            context "and comment is not found" do

                before { delete "/api/videos/#{video_id}/comments/1000" }

                it 'returns a status code of 404' do
                    expect(response).to have_http_status(404)
                end

                it "returns error messages of not found in JSON" do
                    #json = JSON.parse(response.body, symbolize_names: true)

                    expect(json).not_to be_empty
                    expect(json[:errors][:messages]).to eq({:comment=>"can't be found"})
                end

            end

        end

        context "if video is not found" do

            before { get "/api/videos/10000/comments" }

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
