class AddMatchesTable < ActiveRecord::Migration
  def change
    create_table(:matches) do |t|
      t.integer :player1_tag, null: false
      t.integer :player2_tag, null: false
      t.references :winner, references: :smashers, index: true
      t.references :loser, references: :smashers, index: true
      t.references :tournament, index: true

      t.timestamps null: false 
    end
  end
end
