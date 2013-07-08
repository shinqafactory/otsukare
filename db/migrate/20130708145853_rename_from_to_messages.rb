class RenameFromToMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :from, :msg_from
  end
end
