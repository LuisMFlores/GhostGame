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

    def play_round
        fragment = ""
    end

    def game_over?

    end

end

game = GhostGame.new(
    Player.new("Luis"),
    Player.new("Merlin")
)