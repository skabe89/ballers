
class Cli

    attr_accessor :current_player, :roster, :working_array

    def initialize
        @current_player = nil
        @roster = []
        @working_array = []
        #every time working array is used, return working array to []
    end

    def start
        #pull random nba trivi
        puts "Hello! Welcome to Ballers!"
        puts "Please wait while we load your players!"
        puts "-------------------"
        puts "trivia"
        Api.load_all
        main_menu
    end

    def main_menu
        puts "-------------------"
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
                puts "Type in the name of the player you want to find"
                full_name_search
            elsif input == "4"
                view_roster
            elsif input == "exit"
                exit_program
            else 
                puts "wrong try again"
                menu_options
            end
    end

    def full_name_search
        input = get_input
        puts "Searching for player by full name..."
        @current_player = Ballers.find_player_by_name(input)
        if @current_player != nil
            puts "Here's the player you were searching for..."
            puts "#{Ballers.all.index(@current_player)}. #{@current_player.full_name}"
            full_name_sub_menu
        else
            puts "We could not find that player"
            main_menu
        end
    end

    def full_name_sub_menu
        puts"----------"
        puts "Your current player is #{current_player_name}"
        puts"----------"
        puts "Enter '1' to add player to your roster."
        puts "Enter '2' to check the player's position."
        puts "Enter '3' to go back to search players by full name."
        puts "Enter '4' to go back to the main menu."
        puts "Enter 'exit' to exit."
        full_name_sub_options
    end

    def full_name_sub_options
        input = get_input
        if input == "1"
           add_to_roster
        elsif input == "2"
           # puts Ballers.player(current_player).position
           puts player_position
           full_name_sub_menu
        elsif input == "3"
            full_name_search
        elsif input == "4"
            mail_menu
        elsif input == "exit"
            exit_program
        end
    end

    def player_position
        position = Ballers.player(current_player).position
        position == "" ? "I'm sorry, this player's position has not been entered into our database yet. Stay tuned!" : position
    end

    def current_player_name
        Ballers.player(current_player).full_name
    end

    def get_input
        print "Enter your selection: "
        gets.strip
       
    end

    def add_to_roster
        if roster.length == 5
            puts "You can only have 5 players on the floor coach!"
            main_menu
        else
            puts "#{current_player_name} has been added to your roster!"
            @roster << current_player
            main_menu
        end
    end

    def view_roster
        @roster.each{|name| puts Ballers.player(name).full_name}
        main_menu
    end

    def exit_program
        puts "See you later!"
        exit
    end
end
