class AddSlugToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :slug, :string
  end
end
