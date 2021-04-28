class Video < ApplicationRecord
  has_many :user_favourite_videos       
  has_many :users, through: :user_favourite_videos
end
