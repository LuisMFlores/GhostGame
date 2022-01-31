require "byebug"
require_relative "Player"

class Ghost

    def initialize(*players)
        @dictionary = Set.new(File.readlines("dictionary.txt").map(&:chomp))
        @players = players
        @fragment = ""
        @losses = Hash.new { |loss, player| loss[player] = 0 }
    end

end

if __FILE__ == $PROGRAM_NAME
    ghost_game = Ghost.new(
        Player.new("Luis"),
        Player.new("Merlin")
    )  
end