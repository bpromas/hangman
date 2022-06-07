require './game.rb'
require './text_printer'

include TextPrinter

def start_option
    puts message(:press_for_new)
    puts message(:press_for_load)
    option = gets.chomp
    if option == "1" || option == "2"
        return option
    else
        puts message(:invalid_option)
        start_option
    end
end

print_instructions
print_man(6)
puts message(:welcome)
option = start_option
game = Game.new
option == "1" ? game.player_turn : game.load_game
