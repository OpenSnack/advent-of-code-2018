def closest(i, j, points)
    dists = points.map {|x, y| (x - i).abs + (y - j).abs}.each_with_index.to_a.sort {|d1, d2| d1[0] <=> d2[0]}
    min_dists = dists.select {|d, k| d == dists.min {|d1, d2| d1[0] <=> d2[0]}[0]}
    min_dists.size == 1 ? min_dists[0][1] : -1
end

points = File.open('input.txt').readlines.map {|p| p.strip.split(?,).map &:to_i}
bbox = {
    xmin: points.map {|x, y| x}.min,
    ymin: points.map {|x, y| y}.min,
    xmax: points.map {|x, y| x}.max,
    ymax: points.map {|x, y| y}.max
}

indices = Array.new(points.size, 0)

bound_points = {
    xmin: points.select {|x, y| x == bbox[:xmin]},
    xmax: points.select {|x, y| x == bbox[:xmax]},
    ymin: points.select {|x, y| y == bbox[:ymin]},
    ymax: points.select {|x, y| y == bbox[:ymax]}
}

File.open('output', 'w') do |file|
    (bbox[:xmin]..bbox[:xmax]).each do |x|
        (bbox[:ymin]..bbox[:ymax]).each do |y|
            idx = closest(x, y, points)
            file.write('%2.0f ' % idx)
            if idx > -1
                indices[idx] += 1
            end
        end
        file.write("\n")
    end
end
