class AddPlayersTable < ActiveRecord::Migration
  def change
    create_table(:smashers) do |t|
      t.string :tag, null: false
      t.integer :wins, default: 0, null: false
      t.integer :loses, default: 0, null: false

      t.timestamps null: false 
    end
  end
end
