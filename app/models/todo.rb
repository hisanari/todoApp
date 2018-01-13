class Todo < ApplicationRecord
  belongs_to :task_list

  validates :item, presence: true, length: { maximum: 20 }
  validates :todo_limit, presence: true
  validates :status, presence: true

  enum status: { before_work: 0, done: 1, expired: 2 }

  scope :search_todo, ->(task_list_id) { where(task_list_id: task_list_id) }
  scope :search_before_work, -> { where(status: 0) }
  scope :search_done, -> { where(status: 1) }
  scope :fast_todo, -> { order(:todo_limit).first }
end
