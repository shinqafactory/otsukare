class AddResidenceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :residence, :integer
  end
end
