class Comment < ApplicationRecord
  belongs_to :video
  validates :content, :rating, presence: true
  validates :rating, inclusion: { in: 0..5}
end
