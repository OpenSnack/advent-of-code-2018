poly = File.open('5-input.txt').read.strip

idx = 0
while idx < poly.size
    if poly[idx].swapcase == poly[idx+1]
        poly.slice!(idx, 2)
        idx = [0, idx-1].max
    else
        idx += 1
    end
end

puts poly.size
