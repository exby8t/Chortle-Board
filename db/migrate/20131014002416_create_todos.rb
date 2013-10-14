class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.references :member
      t.references :task
      t.integer :year
      t.integer :month
      t.integer :week
      t.integer :day
      t.references :family
      t.boolean :is_completed

      t.timestamps
    end
    add_index :todos, :member_id
    add_index :todos, :task_id
    add_index :todos, :family_id
  end
end
