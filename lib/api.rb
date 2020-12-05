class Api


    def self.url
        "https://www.balldontlie.io/api/v1/players"
    end

    def self.load_all
        current_page = 0
        until current_page == 50
            page_number = "?page=#{current_page}"
            response = RestClient.get(url+page_number)
            data = JSON.parse(response.body)
            data["data"].each do |player|
                player = Ballers.new(player)
            end
            current_page += 1
        end
    end

end
