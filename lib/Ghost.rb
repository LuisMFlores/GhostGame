require "Set"
require "byebug"
require_relative "Player"

class GhostGame

    ALPHABET = ("a".."z")
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
        puts "#{winner.name} is the winner!"
    end

    def alter_losses
        losses[players[2]] = 4
        losses[players[1]] = 2
    end

    private

    attr_reader :players, :dictionary, :fragment, :losses

    def welcome
        system("clear")
        puts "---Welcome to Ghost Game---"
        players.each do |player|
            sleep(0.1)
            puts player.name
        end
        sleep(5)
    end

    def winner
        losses.find { |player, _ | losses[player] < MAX_LOSS_COUNT }.first
    end

    def current_player
        players.first
    end

    def previous_player
        (players.length - 1).downto(0) { |idx| return players[idx] if losses[players[idx]] < MAX_LOSS_COUNT }
    end

    def play_round
        system("clear")
        @fragment = ""

        until round_over?
            letter = current_player.prompt
            until valid_letter?(letter)
            invalid_letter_prompt(letter)
            puts "Current fragment: #{fragment}"
            letter = current_player.prompt
            end
            @fragment << letter
            rotate_player!
        end

        update_standings
        display_standings
        sleep(2)
    end

    def losses_formatted(player)
        "GHOST".slice(0,losses[player])
    end

    def update_standings
        system("clear")
        if losses[previous_player] == MAX_LOSS_COUNT - 1
            puts "#{previous_player.name} has been eliminated"
        else
            puts "#{previous_player.name} gets a letter!"
        end
        losses[previous_player] += 1


    end

    def display_standings
        players.each do |player|
            if losses[player] < MAX_LOSS_COUNT
                puts "#{player.name} has collected: #{losses_formatted(player)}"
                sleep(0.1)
            end
        end
        sleep(5)
    end

    def invalid_letter_prompt(letter)
        system("clear")
        puts "#{current_player.name} letter '#{letter}' is invalid! Please try again!"
    end

    def valid_letter?(letter)
        return false unless ALPHABET.include?(letter)
        dictionary.any? { |word| word.start_with?(fragment + letter)}
    end

    def round_over?
        dictionary.include?(fragment)
    end

    def rotate_player!
        players.rotate!
        players.rotate! until losses[current_player] < MAX_LOSS_COUNT
    end

    def game_over?
        losses.count { |player,losses| losses < MAX_LOSS_COUNT} == 1
    end

end

game = GhostGame.new(
    Player.new("Luis"),
    Player.new("Merlin"),
    Player.new("Jean")
)