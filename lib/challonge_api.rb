module ChallongeApi

    API_KEY = 'abD064HHlRhyEwgQUXBLpZTwwLxO0QVVsGi6ZuiY'

    def getTournament tournament
        url = "https://api.challonge.com/v1/tournaments/" + tournament + ".json"
        return HTTP::get(url, :params => {:api_key => API_KEY, :tournament => tournament, :include_participants => 1, :include_matches => 1}).to_s
    end
end