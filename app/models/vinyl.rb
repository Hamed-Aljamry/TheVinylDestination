class Vinyl < ApplicationRecord
  belongs_to :user
  belongs_to :song, optional: true
  has_one_attached :photo
end
