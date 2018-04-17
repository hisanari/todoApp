class TaskList < ApplicationRecord
  belongs_to :user
  has_many :todos, dependent: :destroy

  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 20 }
  validates :title, uniqueness: { scope: :user_id }

  scope :created_latest, -> { order('created_at DESC') }
  scope :user_tasklist, ->(id) { find_by(id: id) }
end
