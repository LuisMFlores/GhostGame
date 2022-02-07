require "Ghost"
require "Player"
require "byebug"

describe "Ghost" do

    let(:ghost_game) { GhostGame.new(Player.new("Luis"), Player.new("Merlin")) }
   
    describe "#winner" do
        it "should return the winner of the game" do
            ghost_game.losses[ghost_game.players.first] = 1
            ghost_game.losses[ghost_game.players.last] = 6
            expect(ghost_game.winner).to eq(ghost_game.players.first)
        end
    end

    describe "#current_player" do
        it "should return the current player" do
            expect(ghost_game.current_player).to eq(ghost_game.players.first)
            ghost_game.rotate_player!
            expect(ghost_game.current_player).to eq(ghost_game.players.select { |player| player.name == "Merlin"}.first)
        end
    end

end