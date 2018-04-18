class AddIndexToTaskLists < ActiveRecord::Migration[5.1]
  def change
    add_index :task_lists, %i[user_id title], unique: true
  end
end
