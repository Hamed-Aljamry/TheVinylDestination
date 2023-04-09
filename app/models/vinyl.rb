class Vinyl < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  attribute :spotify_url, :string
end
