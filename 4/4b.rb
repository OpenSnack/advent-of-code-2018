require 'date'

in_order = []
File.open('4-input.txt').readlines.map {|l| l.strip}.each do |log|
    datetime, action = log[1..-1].split(']')
    time = DateTime.parse(datetime)
    in_order.push([time, action.strip])
end

guards = Hash.new {|h, k| h[k] = {total: 0, mins: Array.new(60, 0)}}
in_order.sort! {|l1, l2| l1[0] <=> l2[0]}

guard = in_order[0][1].split[1][1..-1].to_i
in_order.each_cons(2) do |prev, log|
    if log[1].start_with? 'Guard'
        guard = log[1].split[1][1..-1].to_i
    elsif log[1] == 'wakes up'
        guards[guard][:total] += log[0].min - prev[0].min + 1
        (prev[0].min...log[0].min).each {|min| guards[guard][:mins][min] += 1}
    end
end

top_mins = guards.entries.map do |g|
    idx = g[1][:mins].find_index {|min| min == g[1][:mins].max}
    [g[0], idx, g[1][:mins][idx]]
end

res = top_mins.max {|e1, e2| e1[2] <=> e2[2]}
puts res[0] * res[1]
