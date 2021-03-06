class Topic < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name,
            presence: true,
            uniqueness: {
              case_sensitive: false,
              scope: :creator_id
            }
  validates :slug, presence: true, uniqueness: true
  validates :creator, presence: true

  has_many :blips
  has_many :radars, through: :blips

  belongs_to :creator, class_name: "User"

  def self.techradar
    find_or_create_by!(name: "techradar.io", creator: User.admin)
  end

  def self.blippable(radar)
    user = radar.owner
    where(creator_id: user).reject do |topic|
      radar.topic?(topic)
    end
  end
end
