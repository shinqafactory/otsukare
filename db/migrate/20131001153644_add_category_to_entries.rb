class AddCategoryToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :category, :integer
  end
end
