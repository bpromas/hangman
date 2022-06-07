require 'json'
require './text_printer'

class Game
    include TextPrinter

    def initialize
        @miss_count = 0
        @answer = pick_random_word.upcase
        @guesses = []
    end

    def player_turn
        if game_won?
            puts message(:congratulations, @answer)
        elsif game_lost?
            puts message(:game_over, @answer)
        else
            print_man(@miss_count)
            print_word(@answer, @guesses)
            guess = get_player_guess
            case guess
            when 'SAVE'
                save_game
            else
                make_guess(guess)
                player_turn
            end
        end
    end

    def load_game
        File.open('save_game.json', 'r') do |file|
          game_from_json(file)
        end
        player_turn
    end

    def save_game
        File.open('save_game.json', 'w') do |file|
            file.puts(game_to_json)
        end
    end

    private

    def pick_random_word
        file = File.open('google-10000-english-no-swears.txt', mode='r')
        line = rand(1..9894)
        word = ""
        line.times { word = file.gets.chomp }
        file.close
        word.length.between?(5, 12) ? word : pick_random_word
    end

    def get_player_guess
        puts message(:make_a_guess)
        guess = gets.chomp.upcase
        if guess == 'SAVE' || guess == 'SOLVE' || (guess.match?(/[[:alpha:]]/) && guess.length == 1)
            if @guesses.include?(guess)
                puts message(:repeat_guess)
                get_player_guess
            else
                guess
            end
        else
            puts message(:invalid_guess)
            get_player_guess
        end
    end

    def make_guess(guess)
        @guesses << guess
        @miss_count += 1 unless @answer.include?(guess)
    end

    def game_won?
        @answer.split("").all? { |letter| @guesses.include? letter }
    end

    def game_lost?
        @miss_count >= 6
    end

    def game_to_json
        JSON.dump({
                    miss_count: @miss_count,
                    answer: @answer,
                    guesses: @guesses
                  })
    end

    def game_from_json(save_game)
        game_data = JSON.parse(File.read(save_game))

        @miss_count = game_data['miss_count']
        @answer = game_data['answer']
        @guesses = game_data['guesses']
      end
end