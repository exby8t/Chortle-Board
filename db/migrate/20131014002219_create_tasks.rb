class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :points
      t.references :interval
      t.references :category
      t.integer :age_limit
      t.boolean :is_active

      t.timestamps
    end
    add_index :tasks, :interval_id
    add_index :tasks, :category_id
  end
end
