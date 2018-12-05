full_poly = File.open('5-input.txt').read.strip

def react(poly)
    idx = 0
    while idx < poly.size
        if poly[idx].swapcase == poly[idx+1]
            poly.slice!(idx, 2)
            idx = [0, idx-1].max
        else
            idx += 1
        end
    end
    poly
end

res = (?A..?Z).map {|l| react(full_poly.dup.chars.reject {|c| c == l || c == l.swapcase}.join)}
puts res.map(&:size).min
