coords = []
File.open('10-input.txt').readlines.each do |s|
    parts = s.strip.scan /<(.*?)>/
    coords.push({
        pos: parts[0][0].split(', ').map(&:to_i),
        vel: parts[1][0].split(', ').map(&:to_i)
    })
end

xdiff = 1/0.0
seconds = 0

while true
    seconds += 1

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

p seconds - 1
