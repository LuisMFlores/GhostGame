require "byebug"
require_relative "Player"

class Ghost

    MAX_LOSS_COUNT = 5

    def initialize(*players)
        @dictionary = Set.new(File.readlines("dictionary.txt").map(&:chomp))
        @players = players
        @fragment = ""
        @losses = Hash.new { |loss, player| losses[player] = 0 }
    end

    def run
        play_round until game_over?
        puts "#{Winner} is the winner!"
    end

    def play_round

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

end

if __FILE__ == $PROGRAM_NAME
    ghost_game = Ghost.new(
        Player.new("Luis"),
        Player.new("Merlin")
    )  
end