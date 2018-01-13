class RenameLimitColumnToTodos < ActiveRecord::Migration[5.1]
  def change
    rename_column :todos, :limit, :todo_limit
  end
end
