class Todo < ApplicationRecord
  belongs_to :task_list

  validates :item, presence: true, length: { maximum: 20 }
  validates :limit, presence: true
  validates :status, presence: true

  enum status: { before_work: 0, done: 1, expired: 2 }
end
