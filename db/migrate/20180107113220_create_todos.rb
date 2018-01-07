class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.string :item, null: false
      t.date :limit, null: false
      t.integer :status, null: false, default: 0
      t.references :task_list, foreign_key: true

      t.timestamps
    end
    add_index :todos, %i[task_list_id limit status]
  end
end
