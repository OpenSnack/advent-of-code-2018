PUZZLE_INPUT = 8561

def power_level(x, y, sn)
    return ((((x + 10) * y) + sn) * (x + 10)).to_s.rjust(3, ?0)[-3].to_i - 5
end

max_xy = nil
max_power = 0

(1..300).each_cons(3) do |xs|
    (1..300).each_cons(3) do |ys|
        power = xs.product(ys).reduce(0) {|sum, coord| sum + power_level(*coord, PUZZLE_INPUT)}
        if power > max_power
            max_xy = [xs[0], ys[0]]
            max_power = power
        end
    end
end

puts max_xy.join(',')
