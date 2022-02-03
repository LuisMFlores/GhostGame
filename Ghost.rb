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

end

game = GhostGame.new(
    Player.new("Luis"),
    Player.new("Merlin")
)