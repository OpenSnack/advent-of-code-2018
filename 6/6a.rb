# find points that are definitely on the edge (establish bounding box)
# for any other point P, find the nearest point Q on each edge and verify that either:
#    P is orthogonally as far or further from that edge than Q (bounded)
#    or there's a point "further outside" P that covers its infinite side
# compute closest point to each point in bounding box
# find largest area among bounded points

def on_edge(x, y, bbox)
    x == bbox[:xmin] || x == bbox[:xmax] || y == bbox[:ymin] || y == bbox[:ymax]
end

def inside_infinite(x, y, points, bound_points)
    return true if bound_points[:xmin].map {|px, py| 
        (x - px < (y - py).abs) &&
        points.select {|cx, cy| cx < x && y.between?(*[py, cy].sort)}.size == 0
    }.all? ||
    bound_points[:xmax].map {|px, py| 
        (px - x < (y - py).abs) &&
        points.select {|cx, cy| cx > x && y.between?(*[py, cy].sort)}.size == 0
    }.all? ||
    bound_points[:ymin].map {|px, py| 
        (y - py < (x - px).abs) &&
        points.select {|cx, cy| cy < y && x.between?(*[px, cx].sort)}.size == 0
    }.all? ||
    bound_points[:ymax].map {|px, py| 
        (py - y < (x - px).abs) &&
        points.select {|cx, cy| cy > y && x.between?(*[px, cx].sort)}.size == 0
    }.all?
    false
end

def closest(i, j, points)
    dists = points.map {|x, y| (x - i).abs + (y - j).abs}.each_with_index.to_a.sort {|d1, d2| d1[0] <=> d2[0]}
    min_dists = dists.select {|d, k| d == dists.min {|d1, d2| d1[0] <=> d2[0]}[0]}
    min_dists.size == 1 ? min_dists[0][1] : -1
end

points = File.open('6-input.txt').readlines.map {|p| p.strip.split(?,).map &:to_i}
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

bounded_points = points.each_with_index.reject {|p, i| on_edge(p[0], p[1], bbox) || inside_infinite(p[0], p[1], points, bound_points)}.map {|p, i| i}.to_a

(bbox[:xmin]..bbox[:xmax]).each do |x|
    (bbox[:ymin]..bbox[:ymax]).each do |y|
        idx = closest(x, y, points)
        if idx > -1
            indices[idx] += 1
        end
    end
end

puts indices.each_with_index.select {|count, i| bounded_points.include? i}.max {|i, j| i[0] <=> j[0]}[0]
