require 'rails_helper'

RSpec.describe Comment, type: :model do

    context "validations" do
        it { should validate_presence_of(:content) }
        it { should validate_presence_of(:rating) }
        it { should validate_inclusion_of(:rating).in_range(0..5)}
    end

    context "relationships" do
        it { should belong_to(:video) }

    end

end
