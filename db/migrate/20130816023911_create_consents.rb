class CreateConsents < ActiveRecord::Migration
  def change
    create_table :consents do |t|
      t.integer :consent_user_id
      t.integer :entry_id
      t.integer :user_id

      t.timestamps
    end
  end
end
