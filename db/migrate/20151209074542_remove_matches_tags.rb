class RemoveMatchesTags < ActiveRecord::Migration
  def change
    remove_column :matches, :player1_tag
    remove_column :matches, :player2_tag
  end
end
