class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :email
      t.integer :age
      t.integer :gender
      t.string :position
      t.string :occupation
      t.string :sns_flstring
      t.integer :thx_point_sum

      t.timestamps
    end
  end
end
