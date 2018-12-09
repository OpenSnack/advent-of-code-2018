def marble_game(players, highest)
    scores = Array.new(players, 0)
    marbles = [*0..highest]
    circle = []
    current_idx = 0
    current_player = 0

    while marbles.size > 0
        if marbles[0] > 0 && marbles[0] % 23 == 0
            scores[current_player] += marbles.shift
            current_idx = back_seven(current_idx, circle.size)
            scores[current_player] += circle.delete_at(current_idx)
        else
            current_idx = next_index(current_idx, circle.size)
            circle.insert(current_idx, marbles.shift)
        end
        current_player = (current_player + 1) % scores.size
    end

    return scores.max
end

def next_index(idx, c_size)
    return c_size if c_size < 2
    return (idx + 2) % c_size
end

def back_seven(idx, c_size)
    new_idx = idx - 7
    return c_size + new_idx if new_idx < 0
    return new_idx
end

input = File.open('9-input.txt').read.strip.split
p marble_game(input[0].to_i, input[-2].to_i)
