class SmashersController < ApplicationController

    def index
        @smashers = Smasher.order(:tag)
    end

    def show
        @smasher = Smasher.find(params[:id])

        ## Compile records again other smashers
        @records = Hash.new
        @smasher.matches.each do |match|
            if match.winner_id == @smasher.id
                opponent = Smasher.find match.loser_id
                if @records.has_key? opponent.tag
                    @records[opponent.tag]['wins'] += 1
                else
                    @records[opponent.tag] = { 'wins' => 1, 'losses' => 0 }
                end
            else
                opponent = Smasher.find match.winner_id
                if @records.has_key? opponent.tag
                    @records[opponent.tag]['losses'] += 1
                else
                    @records[opponent.tag] = { 'wins' => 0, 'losses' => 1 }
                end
            end
        end

        ## Calculate biggest rival
        @rival = { 'tag' => @records.keys.first, 'record' => @records.values.first, 'setCount' => 0 }
        @records.each do |key, value|
            if (@rival['record']['wins'] - @rival['record']['losses']).abs > (value['wins'] - value['losses']).abs
                @rival = { 'tag' => key, 'record' => value, 'setCount' => 0 }
            end
        end
        @smasher.matches.each do |match|
            if Smasher.find(match.winner_id).tag == @rival['tag'] || Smasher.find(match.loser_id).tag == @rival['tag']
                @rival['setCount'] += 1
            end
        end
    end

    def doesExist
        smasher = Smasher.find_by(tag: params[:tag])
        respond_to do |format|
            format.js {}
            format.json {
                if smasher != nil
                    render json:  { "does_exist" => "true" }
                else
                    render json: { "does_exist" => "false" }
                end
            }
        end
    end
end