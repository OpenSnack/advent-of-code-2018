def manhattan(p1, p2)
    (p2[0] - p1[0]).abs + (p2[1] - p1[1]).abs
end

points = File.open('6-input.txt').readlines.map {|p| p.strip.split(?,).map &:to_i}
bbox = {
    xmin: points.map {|x, y| x}.min,
    ymin: points.map {|x, y| y}.min,
    xmax: points.map {|x, y| x}.max,
    ymax: points.map {|x, y| y}.max
}

r_size = 0
(bbox[:xmin]..bbox[:xmax]).each do |x|
    (bbox[:ymin]..bbox[:ymax]).each do |y|
        if points.map {|p| manhattan([x, y], p)}.reduce(:+) < 10000
            r_size += 1
        end
    end
end

puts r_size
