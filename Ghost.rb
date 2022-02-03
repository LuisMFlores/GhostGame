require "Set"
require "byebug"
require_relative "Player"

class GhostGame

    MAX_LOSS_COUNT = 5

    def initialize(*players)
        @players = players
        @dictionary = Set.new(File.readlines("dictionary.txt").map(&:chomp))
        @fragment = ""
        @losses = Hash.new { |losses, player| losses[player] = 0 }
    end

    def run
        welcome
        play_round until game_over?
        puts "#{winner} is the winner!"
    end

    private

    attr_reader :players, :dictionary, :fragment, :losses

    def welcome
        system("clear")
        puts "---Welcome to Ghost Game---"
        players.each do |player|
            sleep(0.1)
            puts player
        end
    end

    def winner
        losses.find { |player, loss| losses[player] < MAX_LOSS_COUNT }.first
    end

    def current_player
        players.first
    end

    def previous_player
        (players.length - 1).downto(0) { |idx| return players[idx] if losses[players[idx]] < MAX_LOSS_COUNT }
    end

    def play_round
        fragment = ""

        until round_over?
            letter = current_player.prompt
            until valid_letter?(letter)
            invalid_letter_prompt(letter)
            letter = current_player.prompt
            end
            rotate_player!
        end

    end

    def invalid_letter_prompt(letter)
        puts "#{current_player} letter #{letter} is invalid! Please try again!"
    end

    def valid_letter?(letter)
        dictionary.any? { |word| word.start_with?(letter)}
    end

    def round_over?
        dictionary.inclue?(fragment)
    end

    def rotate_player!
        players.rotate!
        players.rotate! until losses[current_player] < MAX_LOSS_COUNT
    end

    def game_over?

    end

end

game = GhostGame.new(
    Player.new("Luis"),
    Player.new("Merlin")
)