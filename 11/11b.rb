PUZZLE_INPUT = 8561

def power_level(x, y, sn)
    return ((((x + 10) * y) + sn) * (x + 10)).to_s.rjust(3, ?0)[-3].to_i - 5
end

memo = {}
cells = Array.new(300) {|x| Array.new(300) {|y| power_level(x+1, y+1, PUZZLE_INPUT)}}

max_xy = nil
max_power = 0

(1..300).each do |size|
    (1..300-size+1).each do |x|
        (1..300-size+1).each do |y|
            if size == 1
                memo[[x, y]] = cells[x-1][y-1]
            else
                outer_row = (x...x+size).map {|outer_x| cells[outer_x-1][y+size-2]}.sum
                outer_col = (y...y+size-1).map {|outer_y| cells[x+size-2][outer_y-1]}.sum
                memo[[x, y]] += outer_row + outer_col
            end
            if memo[[x, y]] > max_power
                max_xy = [x, y, size]
                max_power = memo[[x, y]]
            end
        end
    end
end

puts max_xy.join(',')
