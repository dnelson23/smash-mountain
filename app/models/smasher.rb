class Smasher < ActiveRecord::Base

    has_many :wins, :class_name => "Match", :foreign_key => "winner_id"
    has_many :losses, :class_name => "Match", :foreign_key => "loser_id"

    def matches
        Match.where("winner_id = #{self.id} or loser_id = #{self.id}")
    end

    def tournaments
        tourneys = Array.new

        self.matches.each do |match|
            if !tourneys.include? match.tournament
                tourneys.push match.tournament
            end
        end

        return tourneys
    end
end