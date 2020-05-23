class Hanoi
    attr_reader :pegs

    def initialize
        @pegs = Array.new(3) {Array.new(4)}
        fill_pegs
    end

    def fill_pegs
        (1..4).each.with_index {|size,idx| @pegs.first[idx] = size}
    end

    def valid_pos?(pos)
        "012".include? pos
    end

    def valid_move?(start_pos,end_pos)
        return false if pegs[start_pos].all? {|ring| ring.nil?}
        return true if pegs[end_pos].all? {|ring| ring.nil?}
        return true if get_top_ring(pegs[start_pos]).last < get_top_ring(pegs[end_pos]).last
        return false
    end

    def get_top_ring(peg)
        peg.each.with_index {|ring,idx| return [idx,ring] if !ring.nil?}
        return [peg.length,nil]
    end

    def make_move(start_pos,end_pos)
        ring = get_top_ring(pegs[start_pos])
        new_pos = get_top_ring(pegs[end_pos]).first-1
        pegs[start_pos][ring.first] = nil
        pegs[end_pos][new_pos] = ring.last
    end

    def game_over?
        return true if pegs[1].none? {|peg| peg.nil?}
        return true if pegs[2].none? {|peg| peg.nil?}
        return false
    end

    def render
        peg_list = {
            nil => "   |   ",
            1 => "   *   ",
            2 => "  ***  ",
            3 => " ***** ",
            4 => "*******"
        }
        puts "#{peg_list[pegs[0][0]]} #{peg_list[pegs[1][0]]} #{peg_list[pegs[2][0]]}"
        puts "#{peg_list[pegs[0][1]]} #{peg_list[pegs[1][1]]} #{peg_list[pegs[2][1]]}"
        puts "#{peg_list[pegs[0][2]]} #{peg_list[pegs[1][2]]} #{peg_list[pegs[2][2]]}"
        puts "#{peg_list[pegs[0][3]]} #{peg_list[pegs[1][3]]} #{peg_list[pegs[2][3]]}"
        puts "   0       1       2   "
    end

    def get_pos
        pos = nil
        until pos && valid_pos?(pos)
            puts "Invalid peg" if pos
            print ">> "
            pos = gets.chomp
        end
        return pos.to_i
    end

    def play
        until game_over?
            start_pos = nil
            end_pos = nil
            until start_pos && end_pos && valid_move?(start_pos,end_pos)
                system('clear')
                render
                puts "What peg do you want to move from?"
                start_pos = get_pos
                puts "What peg do you want to move to?"
                end_pos = get_pos
            end
            make_move(start_pos,end_pos)
        end
        puts "CONGRATULATIONS! YOU WON!"
        sleep(2)
    end
end

if __FILE__ == $PROGRAM_NAME
    game = Hanoi.new
    game.play
end