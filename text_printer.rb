module TextPrinter
    def message(prompt, arg = nil)
        {
            welcome: "Welcome to Hangman! Would you like to load your game or start a new game?",
            press_for_new: "Press 1 for New Game",
            press_for_load: "Press 2 to Load Game",
            invalid_option: "Invalid option!",
            make_a_guess: "What's your guess?",
            invalid_guess: "Invalid guess. You may type a single character, or the word 'save'.",
            repeat_guess: "This letter has already been guessed.",
            congratulations: "Congratulations! The answer was #{arg}! You beat the game!",
            game_over: "Game over. The answer was #{arg}. Better luck next time!"
        }[prompt]
    end

    def print_word(word, guesses)
        word_array = word.split('')
        wrong_guesses = guesses - word_array

        word_array.each_with_index do |letter, i|
            unless guesses.include? letter then
                word_array[i] = "_"
            end
        end

        puts "#{word_array.join(" ")} // Wrong guesses: #{wrong_guesses.join(", ")}"
    end

    def print_man(miss_count)
        case miss_count
        when 1
            puts " O"
        when 2
            puts " O"
            puts " |"
        when 3
            puts " O"
            puts "/|"
        when 4
            puts " O"
            puts "/|\\"
        when 5
            puts " O"
            puts "/|\\"
            puts "/"
        when 6
            puts " O"
            puts "/|\\"
            puts "/ \\"
        end
    end

    def print_instructions
        puts "INSTRUCTIONS: 
Hangman is a word guessing game.

At the beginning of the game, a word between 5 and 12 characters will be randomly picked, and a blank representation will be shown:

_ _ _ _ _ _

Every turn you may guess a letter by typing out a single letter.
If the letter is in the word, it will be revealed to you.

For instance, if the word was TREES, and you guessed the letter E:

_ _ E E _

Incorrect guesses will slowly draw a man on your screen, and once the man is complete, the game is over, and you lose.

 O
/|\\
/ \\

If you wish to stop and come back later, you may simply type 'SAVE' to save and quit the game.

The game is won by completing the word through your guesses.

Good luck!"
    end
end