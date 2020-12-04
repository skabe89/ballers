class Api


    def self.url
        "https://www.balldontlie.io/api/v1/players"
    end

    # def self.response
    #     response = RestClient.get(self.url)
    # end

    # def self.parse_json
    #     data = JSON.parse(response.body)
    # end

    # def self.load_players
    #     response = RestClient.get(url)
    #     data = JSON.parse(response.body)
    #     data["data"].each do |player|
    #         player = Ballers.new(player)
    #     end
    # end

    def self.load_all
        current_page = 0
        until current_page == 25
            page_number = "?page=#{current_page}"
            response = RestClient.get(url+page_number)
            data = JSON.parse(response.body)
            data["data"].each do |player|
                player = Ballers.new(player)
            end
            current_page += 1
        end
    end

    # def self.list_players
    #     Ballers.list_players
    # end
end

# Api.load_all
# binding.pry
