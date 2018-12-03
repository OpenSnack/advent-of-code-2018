ids = File.open('2-input.txt').readlines().map {|s| s.delete("\n")}.map {|id| id.chars}
ids.each do |id|
    ids.each do |comp|
        diff = 0
        diff_letter = -1
        id.size.times do |i|
            if comp[i] != id[i]
                diff += 1
                diff_letter = i
                if diff == 2
                    break
                end
            end
        end
        if diff == 1
            id.delete_at diff_letter
            puts id.join
            exit
        end
    end
end
