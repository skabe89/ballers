
class Cli

    def start
        #pull random nba trivi
        puts "Hello! Welcome to Ballers!"
        puts "Please wait while we load your players!"
        puts "-------------------"
        puts "trivia"
        puts "-------------------"
        Api.load_all
        main_menu
    end

    def main_menu
        puts "Enter '1' to search for players by last name."
        puts "Enter '2' to search for players by first name."
        puts "Enter '3' to search for a player by full name."
        puts "Enter '4' to look at your current dream roster!"
        puts "Type 'exit' to exit the program"
        menu_options
    end

    def menu_options
        input = get_input
            if input == "1"
                puts "thanks for searching player by last name"
            elsif input == "2"
                puts "thanks for searching player by first name"
            elsif input == "3"
                puts "thanks for searching player by full name"
            elsif input == "4"
                puts "heres your roster"
            elsif input == "exit"
                puts "see you later!"
                exit
            else 
                puts "wrong try again"
                menu_options
            end
    end

    def get_input
        print "Enter yor selection: "
        gets.strip
    end

end
