class Artist < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :image_path, presence: true
end
