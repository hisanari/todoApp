class TaskList < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title,   presence: true, uniqueness: true, length: { maximum: 20 }
end
