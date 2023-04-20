class Vinyl < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :name, presence: true
  validates :description, presence: true
  validates :artist, presence: true
  validates :genre, presence: true

  def spotify_track
    RSpotify::Track.find(self.track_id)
  end
end
