class CircularList
    attr_reader :size, :curr

    def initialize
        @curr = nil
        @size = 0
    end

    def insert(data, offset=0)
        if @curr == nil
            @curr = ListNode.new(data)
        else
            self.move(offset)
            new_node = ListNode.new(data)
            new_node.prev = @curr
            new_node.next = @curr.next
            @curr.next.prev = new_node
            @curr.next = new_node
            @curr = new_node
        end
        @size += 1
    end

    def remove(offset)
        self.move(offset)
        @curr.prev.next = @curr.next
        @curr.next.prev = @curr.prev
        out_val = @curr.data
        @curr = @curr.next
        @size -= 1
        out_val
    end

    def move(offset)
        direction = offset <=> 0
        offset.abs.times {|n| @curr = direction < 0 ? @curr.prev : @curr.next}
    end
end

class ListNode
    attr_accessor :next, :prev, :data

    def initialize(data, init=false)
        @data = data
        @next = self
        @prev = self
    end
end

def marble_game(players, highest)
    scores = Array.new(players, 0)
    marbles = [*0..highest]
    circle = CircularList.new
    current_player = 0

    while marbles.size > 0
        if marbles[0] > 0 && marbles[0] % 23 == 0
            scores[current_player] += marbles.shift
            scores[current_player] += circle.remove(-7)
        else
            circle.insert(marbles.shift, 1)
        end
        current_player = (current_player + 1) % scores.size
    end

    scores.max
end

input = File.open('9-input.txt').read.strip.split
p marble_game(input[0].to_i, input[-2].to_i * 100)
