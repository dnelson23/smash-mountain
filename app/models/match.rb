class Match < ActiveRecord::Base
    belongs_to :tournament
    belongs_to :winner, class_name: "Smasher", foreign_key: "winner_id"
    belongs_to :loser, class_name: "Smasher", foreign_key: "loser_id"
end