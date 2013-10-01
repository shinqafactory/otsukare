class RemoveResidenceFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :residence, :integer
  end
end
