def exactly2or3(s)
    counts = Hash.new(0)
    s.chars.each do |c|
        counts[c] += 1
    end
    [counts.values.include?(2), counts.values.include?(3)]
end

ids = File.open('2-input.txt').readlines().map {|s| s.delete("\n")}
counts = ids.map {|id| exactly2or3(id)}
puts counts.count {|c| c[0]} * counts.count {|c| c[1]}
