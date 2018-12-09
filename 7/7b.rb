def assign_worker(step, workers, max_workers)
    if workers.size == max_workers
        return false
    end
    workers.push([step, step.ord-4])
    return true
end

def finish_step(steps, step, ready)
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

ready = []
workers = []
[*?A..?Z].reject {|x| steps.keys.include? x}.each {|s| assign_worker(s, workers, 5)}

total_time = 0

while workers.size > 0
    done = []
    workers.each do |w|
        w[1] -= 1
        if w[1] == 0
            finish_step(steps, w[0], ready)
            done.push(w[0])
        end
    end
    done.each {|step| workers.delete_if {|s, t| s == step}}
    ready.dup.each do |s|
        if assign_worker(s, workers, 5)
            ready.delete(s)
        end
    end
    total_time += 1
end

p total_time
