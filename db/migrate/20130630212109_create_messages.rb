class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.string :to
      t.string :from
      t.string :subject
      t.string :body
      t.integer :link_id
      t.integer :thx_point

      t.timestamps
    end
  end
end
