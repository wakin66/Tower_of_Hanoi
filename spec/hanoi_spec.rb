require 'hanoi'

describe Hanoi do
    let(:game) {Hanoi.new}

    describe "#initialize" do
        it "creates @pegs as an array" do
            expect(game.pegs).to be_an(Array)
        end

        it "adds 4 pegs to the first peg" do
            expect(game.pegs.first.length).to eq(4)
        end

        it "lists the pegs in ascending order" do
            expect(game.pegs.first).to eq([1,2,3,4])
        end
    end

    describe "#valid_pos?" do
        it "returns true if given a valid position" do
            expect(game.valid_pos?("1")).to eq(true)
        end

        it "returns false if given an invvalid position" do
            expect(game.valid_pos?("5")).to eq(false)
        end
    end

    describe "#valid_move?" do
        it "returns true if given a valid move" do
            expect(game.valid_move?(0,1)).to eq(true)
        end

        it "returns false if given an invalid move" do
            expect(game.valid_move?(2,1)).to eq(false)
        end
    end

    describe "#get_top_ring" do
        it "takes an array as an argument" do
            expect {game.get_top_ring(game.pegs.first)}.to_not raise_exception
        end

        it "returns an array" do
            expect(game.get_top_ring(game.pegs.first)).to be_an(Array)
        end

        it "returns the first ring on a peg" do
            expect(game.get_top_ring(game.pegs.first)).to eq([0,1])
        end

        it "returns the peg length and nil if the peg is empty" do
            expect(game.get_top_ring(game.pegs.last)).to eq([4,nil])
        end
    end

    describe "#make_move" do
        it "takes two integers as arguments" do
            expect {game.make_move(0,1)}.to_not raise_exception
        end

        it "removes the top ring from peg 1" do
            game.make_move(0,1)
            expect(game.pegs.first.first).to eq(nil)
        end

        it "adds a ring to peg 2" do
            game.make_move(0,1)
            expect(game.pegs[1][3]).to eq(1)
        end
    end

    context "on a new game" do
        describe "render" do
            it "doesn't raise an exception" do
                expect {game.render}.to_not raise_exception
            end
        end

        describe "#game_over?" do
            it "returns false" do
                expect(game.game_over?).to eq(false)
            end
        end

        describe "@pegs" do
            it "has all 4 rings in order on the first peg" do
                expect(game.pegs.first).to eq([1,2,3,4])
            end

            it "has no rings on the second peg" do
                expect(game.pegs[1]).to eq([nil,nil,nil,nil])
            end

            it "has no rings on the third peg" do
                expect(game.pegs.last).to eq([nil,nil,nil,nil])
            end
        end
    end

    context "on game over" do
        before(:each) do
            game.make_move(0,1)
            game.make_move(0,2)
            game.make_move(1,2)
            game.make_move(0,1)
            game.make_move(2,0)
            game.make_move(2,1)
            game.make_move(0,1)
            game.make_move(0,2)
            game.make_move(1,2)
            game.make_move(1,0)
            game.make_move(2,0)
            game.make_move(1,2)
            game.make_move(0,1)
            game.make_move(0,2)
            game.make_move(1,2)
        end

        describe "#game_over?" do
            it "returns true" do
                expect(game.game_over?).to eq(true)
            end
        end

        describe "@pegs" do
            it "has no rings on the first peg" do
                expect(game.pegs.first).to eq([nil,nil,nil,nil])
            end

            it "has no rings on the second peg" do
                expect(game.pegs[1]).to eq([nil,nil,nil,nil])
            end
            
            it "has all 4 rings in order on the third peg" do
                expect(game.pegs.last).to eq([1,2,3,4])
            end
        end
    end
end