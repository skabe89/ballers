
class Cli

    attr_accessor :current_player, :roster, :working_array, :trivia

    def initialize
        @current_player = nil
        @roster = []
        @working_array = []
        @trivia = Trivia.grab
        #every time working array is used, return working array to []
    end

    def start
        #pull random nba trivi
        puts "Hello! Welcome to Ballers!"
        puts "Please wait while we load your players!"
        line_spacer
        puts "Trivia: #{@trivia["question"]}"
        Api.load_all
        puts "Answer: #{@trivia["answer"]}"
        sleep(3)
        main_menu
    end

    def main_menu
        line_spacer
        puts "Main Menu"
        line_spacer
        puts "Enter '1' to search for players by last name."
        puts "Enter '2' to search for players by first name."
        puts "Enter '3' to search for a player by full name."
        puts "Enter '4' to look at your current roster!"
        puts "Type 'exit' to exit the program."
        line_spacer
        menu_options
    end

    def menu_options
        input = get_input
            if input == "1"
                puts "thanks for searching player by last name"
                main_menu
            elsif input == "2"
                puts "thanks for searching player by first name"
                main_menu
            elsif input == "3"
                puts "Type in the name of the player you want to find"
                full_name_search
            elsif input == "4"
                view_roster
            elsif input.upcase == "EXIT"
                exit_program
            else 
                puts "Incorrect user input, try again"
                menu_options
            end
    end

    def full_name_search
        @current_player = nil
        input = get_input
        @current_player = Ballers.find_player_by_name(input)
        if @current_player != nil
            line_spacer
            puts "Here's the player you were searching for..."
            puts "#{Ballers.all.index(@current_player)}. #{@current_player.full_name}"
            full_name_sub_menu
        else
            puts "We could not find that player, sending you back to the main menu"
            main_menu
        end
    end

    def full_name_sub_menu
        line_spacer
        puts "Your current player is #{current_player_name}"
        line_spacer
        puts "Enter '1' to add player to your roster."
        puts "Enter '2' to check the player's position."
        puts "Enter '3' to search for a different player."
        puts "Enter '4' to go back to the main menu."
        puts "Enter 'exit' to exit the program."
        line_spacer
        full_name_sub_options
    end

    def full_name_sub_options
        input = get_input
        if input == "1"
           add_to_roster
        elsif input == "2" 
           puts "#{current_player_name}, #{player_position(@current_player)}"
           full_name_sub_menu
        elsif input == "3"
            full_name_search
        elsif input == "4"
            main_menu
        elsif input.upcase == "EXIT"
            exit_program
        else
            puts "Incorrect user input, try again"
            full_name_sub_menu
        end
    end

    def player_position(i)
        position = Ballers.player(i).position
        position == "" ? "I'm sorry, this player's position has not been entered into our database yet. Stay tuned!" : position
    end

    def current_player_name
        Ballers.player(current_player).full_name
    end

    def get_input
        print "Enter here: "
        gets.strip
       
    end

    def add_to_roster
        if roster.length == 5
            puts "You can only have 5 players in your roster!"
            main_menu
        elsif @roster.include?(current_player)
            puts "#{current_player_name} is already on your team!"
            main_menu
        else
            puts "#{current_player_name} has been added to your roster!"
            @roster << current_player
            main_menu
        end
    end

    def roster_sub_menu
        line_spacer
        puts "Enter '1' to check the position of one of your players."
        puts "Enter '2' to remove players from your roster."
        puts "Enter '3' to go back to the main menu."
        puts "Enter 'exit' to exit the program."
        roster_sub_options
    end

    def roster_sub_options
        input = get_input
        if input == "1"
            roster_check_position_sub_menu
        elsif input =="2"
            roster_delete_sub_menu
        elsif input == "3"
            main_menu
        elsif input.upcase == "EXIT"
            exit_program
        else
            puts "Incorrect user input, try again"
            line_spacer
            view_roster_literal
            roster_sub_menu
        end
    end

    def roster_check_position_sub_menu
        line_spacer
        view_roster_literal
        line_spacer
        puts "Enter the number on the left of the player you would like to check or 'back' to go back to your roster"
        roster_check_position
    end

    def roster_check_position
        input = get_input
        if input.upcase == "BACK"
            view_roster
        elsif [*1..@roster.length].include?(input.to_i)
            puts "#{Ballers.player(@roster[input.to_i - 1]).full_name}, #{player_position(@roster[input.to_i - 1])}"
            view_roster
        else
            take_back_to_roster
        end
    end

    def roster_delete_sub_menu
        line_spacer
        view_roster_literal
        line_spacer
        puts "Enter the number to the left of the player you would like removed from your roster..."
        puts "Enter 'all' to remove all players or 'back' to go back to your roster."
        roster_delete_options
    end

    def roster_delete_options
        input = get_input
        if input.upcase == "ALL"
            make_sure_menu
        elsif input.upcase == "BACK"
            view_roster
        elsif [*1..@roster.length].include?(input.to_i)
            puts "#{Ballers.player(@roster[input.to_i - 1]).full_name} has been removed from your roster"
            @roster.delete_at(input.to_i - 1)
            view_roster
        else
            take_back_to_roster
        end
    end

    def make_sure_menu
        line_spacer
        puts "Are you sure you want to clear your whole roster?"
        puts "Enter 'yes' or 'no'."
        make_sure
    end

    def make_sure
        input = get_input
        if input.upcase == "YES"
            @roster.clear
            line_spacer
            puts "Your roster has been cleared"
            main_menu
        elsif input.upcase == "NO"
            puts "Taking you back to your roster"
            view_roster
        else
            take_back_to_roster
        end
    end

    def view_roster
        if @roster.length == 0
            line_spacer
            puts "Your roster is currently empty" 
            main_menu
        else
            line_spacer
            view_roster_literal
            roster_sub_menu
        end
    end

    def view_roster_literal
        puts "Your roster is currently:"
            @roster.each.with_index(1){|name, index| puts "#{index}. #{Ballers.player(name).full_name}"}
    end

    def line_spacer
        puts "-----------------"
    end

    def take_back_to_roster
        puts "Incorrect user input, taking you back to your roster"
        view_roster
    end

    def exit_program
        puts "See you later!"
        exit
    end
end
