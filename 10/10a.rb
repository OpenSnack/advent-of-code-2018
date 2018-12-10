coords = []
File.open('10-input.txt').readlines.each do |s|
    parts = s.strip.scan /<(.*?)>/
    coords.push({
        pos: parts[0][0].split(', ').map(&:to_i),
        vel: parts[1][0].split(', ').map(&:to_i)
    })
end

xdiff = 1/0.0

while true
    coords.each do |c|
        c[:pos][0] += c[:vel][0]
        c[:pos][1] += c[:vel][1]
    end

    new_xdiff = coords.minmax_by {|c| c[:pos][0]}.map {|c| c[:pos][0]}.reverse.reduce :-
    if new_xdiff > xdiff
        break
    else
        xdiff = new_xdiff
    end
end

coords.each do |c|
    c[:pos][0] -= c[:vel][0]
    c[:pos][1] -= c[:vel][1]
end

bbox = {
    xmin: coords.min_by {|c| c[:pos][0]}[:pos][0],
    xmax: coords.max_by {|c| c[:pos][0]}[:pos][0],
    ymin: coords.min_by {|c| c[:pos][1]}[:pos][1],
    ymax: coords.max_by {|c| c[:pos][1]}[:pos][1]
}

field = Array.new(bbox[:ymax] - bbox[:ymin] + 1) { Array.new(bbox[:xmax] - bbox[:xmin] + 1, '. ') }

coords.each do |c|
    field[c[:pos][1] - bbox[:ymin]][c[:pos][0] - bbox[:xmin]] = '# '
end

field.each do |row|
    row.each do |cell|
        print cell
    end
    puts
end
