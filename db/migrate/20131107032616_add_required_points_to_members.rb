class AddRequiredPointsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :required_points, :integer
  end
end
