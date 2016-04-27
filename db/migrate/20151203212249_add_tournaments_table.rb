class AddTournamentsTable < ActiveRecord::Migration
  def change
    create_table(:tournaments) do |t|
        t.string :name, null: false

        t.timestamps null: false
    end
  end
end
