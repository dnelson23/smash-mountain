class TournamentsController < ApplicationController
    require 'uri'
    include ChallongeApi

    before_action :authenticate_user!

    def upload

    end

    def new
        flash.clear
        tournament = params[:tournament_sub] + "-" + params[:tournament_name]
        @allSmashers = Smasher.all
        
        @tournament = JSON.parse(getTournament tournament)

        if @tournament["errors"]
            flash[:danger] = "We were unable to find the requested tournament. Please check the names and try again."
            redirect_to :back
            return
        end

        @tournament = @tournament["tournament"]

        @smashers = @tournament["participants"]
        @matches = @tournament["matches"]
    end

    def create
        thisTournament = Tournament.find_or_initialize_by(challonge_id: params[:tournament_id])
        if thisTournament.persisted?
            flash[:danger] = "Tournament is already in the database"
            redirect_to action: "upload" 
            return
        else
            thisTournament.name = params[:tournament_name]
            thisTournament.save

            smashersParams = params[:smashers]
            matchesParams = params[:matches]

            smashers = Array.new
            matches = Array.new

            smashersParams.each do |smasher|
                thisSmasher = Smasher.find_or_create_by!(tag: smasher["name"])
                smashers.push({ "challonge_id" => smasher["id"], "smasherObj" => thisSmasher })
            end

            matchesParams.each do |match|
                thisMatch = Match.new
                thisMatch.tournament_id = thisTournament.id
                smashers.each do |smasher|
                    if smasher["challonge_id"] == match["winner_id"]
                        thisMatch.winner_id = smasher["smasherObj"].id
                    elsif smasher["challonge_id"] == match["loser_id"]
                        thisMatch.loser_id = smasher["smasherObj"].id
                    end
                end
                thisMatch.save
            end

            flash[:success] = "Tournament and matches uploaded successfully!"
            render "upload"
        end
    end
end