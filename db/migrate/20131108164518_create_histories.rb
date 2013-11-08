class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :member
      t.integer :year
      t.integer :week
      t.integer :quota
      t.integer :points

      t.timestamps
    end
    add_index :histories, :member_id
  end
end
