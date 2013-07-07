class AddDisplayFlgToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :display_flg, :integer
  end
end
