class TaskList < ApplicationRecord
  belongs_to :user
  has_many :todos, dependent: :destroy

  validates :user_id, presence: true
  validates :title,   presence: true, uniqueness: true, length: { maximum: 20 }

  scope :created_latest, -> { order('created_at DESC') }
  scope :user_tasklist, ->(id) { find_by(id: id) }
end
