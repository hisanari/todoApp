class CreateTaskLists < ActiveRecord::Migration[5.1]
  def change
    create_table :task_lists do |t|
      t.string :title, unique: true, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :task_lists, %i[user_id created_at]
  end
end
