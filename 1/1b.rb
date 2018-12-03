def q1b
    freqs = File.open('1-input.txt').readlines().map {|s| s.delete("\n")}
    reached = Hash.new(0)
    freq_sum = 0
    while true
        freqs.each do |freq|
            freq_sum += freq.to_i
            reached[freq_sum] += 1
            if reached[freq_sum] == 2
                puts freq_sum
                return
            end
        end
    end
end

q1b
