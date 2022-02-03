require "Set"
require "byebug"
require_relative "Player"

class GhostGame

    

    def initialize(*players)
        @players = players
        @dictionary = Set.new(File.readlines("dictionary.txt").map(&:chomp))
        @fragment = ""
        @losses = Hash.new { |losses, player| losses[player] = 0 }
    end

    def run
        play_round until game_over?
        puts "#{winner} is the winner!"
    end

    private

    attr_reader :players, :dictionary, :fragment, :losses

    def winner

    end

    def play_round

    end

    def game_over?

    end

end

game = GhostGame.new(
    Player.new("Luis"),
    Player.new("Merlin")
)