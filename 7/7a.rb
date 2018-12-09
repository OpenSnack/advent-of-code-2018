def do_step(steps, step, ready)
    steps.keys.each do |k|
        steps[k].delete(step)
        if steps[k].size == 0
            steps.delete(k)
            ready.push(k)
        end
    end
end

steps = Hash.new {|h, k| h[k] = []}
File.open('7-input.txt').readlines.each do |s|
    parts = s.strip.split
    steps[parts[7]].push parts[1]
end

ready = [*?A..?Z].reject {|x| steps.keys.include? x}

res = ''
while ready.size > 0
    nxt = ready.sort!.shift
    do_step(steps, nxt, ready)
    res += nxt
end

p res
