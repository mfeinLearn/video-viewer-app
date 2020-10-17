require 'rails_helper'

RSpec.describe Video, type: :model do

    context "validations" do
        it { should validate_presence_of(:title) }
        it { should validate_presence_of(:description) }
        it { should validate_presence_of(:youtube_video_id) }
    end

end
