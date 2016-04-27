class AddMatchesFk < ActiveRecord::Migration
  def change
    add_foreign_key :matches, :smasher, column: :winner_id
    add_foreign_key :matches, :smasher, column: :loser_id
    add_foreign_key :matches, :tournaments
  end
end
