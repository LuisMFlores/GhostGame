require "byebug"
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

    def last_player
        (players.count - 1).downto(0) do |idx|
            return players[idx] if losses[players] < MAX_LOSS_COUNT
        end        
    end

    def record(player)
        "GHOST".slice(0,losses[player])
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



end

if __FILE__ == $PROGRAM_NAME
    ghost_game = Ghost.new(
        Player.new("Luis"),
        Player.new("Merlin")
    )  
end