fabric = Array.new(1000) { Array.new(1000, 0) }
File.open('3-input.txt').readlines().each do |s|
    s.delete("\n")
    coords, dims = s.split('@ ')[1].split(': ')
    x, y = coords.split(',').map {|n| n.to_i}
    w, h = dims.split('x').map {|n| n.to_i}
    (x...x+w).each do |m|
        (y...y+h).each do |n|
            fabric[m][n] += 1
        end
    end
end

puts fabric.map {|arr| arr.count {|n| n > 1}}.sum
