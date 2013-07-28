class RenameToToMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :to, :msg_to
  end
end
