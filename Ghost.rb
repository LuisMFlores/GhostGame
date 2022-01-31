require "byebug"
require "set"
require_relative "Player"

class Ghost

    ALPHABET = ("a".."z").to_s
    MAX_LOSS_COUNT = 5

    def initialize(*players)
        @dictionary = Set.new(File.readlines("dictionary.txt").map(&:chomp))
        @players = players
        @fragment = ""
        @losses = Hash.new { |loss, player| losses[player] = 0 }
    end

    def run
        play_round until game_over?
        puts "#{winner} is the winner!"
    end

    private

    attr_reader :fragment, :dictionary, :losses, :players

    def play_round
        fragment = ""
        welcome

        until round_over?
            take_turn
            next_player!
        end

        update_standings
    end

    def take_turn
        system("Clear")
        puts "It's #{current_player}'s turn!"
        guest = gets.chomp.downcase
        letter = nil

        until letter
            letter = guest

            until valid_play?(letter)
                alert_invalid_move(letter)
                letter = nil
            end

        end

            puts "#{current_player} added the letter '#{letter}' to the fragment."

    end

    def alert_invalid_move(letter)
        puts "Invalid move!!! Try again!"
    end

    def game_over?
        remaining_players == 1
    end

    def remaining_players
        losses.count { |_, v| v < MAX_LOSS_COUNT }
    end

    def winner
        (player, _) = losses.find { |_, losses| losses < MAX_LOSS_COUNT }
        player
    end

    def is_word?(fragment)
        dictionary.include?(fragment)
    end

    def round_over?
        is_word?(fragment)
    end

    def add_letter(letter)
        fragment << letter
    end

    def current_player
        players.first
    end

    def next_player!
        players.rotate!
        players.rotate! until losses[current_player] < MAX_LOSS_COUNT
    end

    def previous_player
        (players.count - 1).downto(0) do |idx|
            return players[idx] if losses[players] < MAX_LOSS_COUNT
        end        
    end

    def record(player)
        "GHOST".slice(0,losses[player])
    end

    def update_standings
        system("clear")
        puts "#{previous_player} spelled #{fragment}"
        puts "#{previous_player} gets a letter!"
        sleep(1)

        if losses[previous_player] == MAX_LOSS_COUNT - 1
            puts "#{previous_player} has been eliminated!"
            sleep(1)
        end

        losses[previous_player] += 1

        display_standings

    end

    def display_standings
        puts "Current standings: "
        players.each { |player| puts "#{player}: #{record(player)}"}
        sleep(2)
    end

    def welcome
        system("clear")
        puts "Let's play a round a ghost!"
        display_standings
    end

    def valid_play?(letter)
        return false unless ALPHABET.include?(letter)
        possible_frag = fragment + letter
        dictionary.any? { |word| word.start_with?(possible_frag) }
    end


end

if __FILE__ == $PROGRAM_NAME
    ghost_game = Ghost.new(
        Player.new("Luis"),
        Player.new("Merlin")
    )  
end