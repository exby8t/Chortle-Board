class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.date :birthdate
      t.references :family
      t.references :member_type

      t.timestamps
    end
    add_index :members, :family_id
    add_index :members, :member_type_id
  end
end
