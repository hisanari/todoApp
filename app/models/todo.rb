class Todo < ApplicationRecord
  belongs_to :task_list

  validates :item, presence: true, length: { maximum: 20 }
  validates :todo_limit, presence: true
  validates :status, presence: true

  enum status: { before_work: 0, done: 1, expired: 2 }

  scope :search_before_work, -> { where(status: 0).order(:todo_limit) }
  scope :search_done, -> { where(status: 1).order(:updated_at) }
  scope :search_expired, -> { where(status: 2) }
  scope :user_todos, ->(ids) { where(task_list_id: ids) }
  scope :latest_todos, -> { order(created_at: :desc).last(5) }

  def params_equal?(todo_params)
    item == todo_params[:item] && todo_limit == Date.strptime(todo_params[:todo_limit])
  end
end
