# we are making the assumption that "....." => "." for everyone since otherwise you may never terminate

def get_key(pots, idx)
    arr = pots[[0, idx-2].max..[pots.size-1, idx+2].min]
    if idx < 2
        arr = (['.'] * (5 - arr.size)) + arr
    elsif idx > pots.size - 3
        arr = arr + (['.'] * (5 - arr.size))
    end
    arr.join
end

input = File.open('12-input.txt').readlines.map &:strip
pots = input[0].split[2].chars
notes = Hash[input[2..-1].map {|line| line.split(' => ')}]
start_idx = 0

20.times do |tm|
    last_patterns = []
    idx = 0
    old_pots = ['.','.'] + pots.dup + ['.','.']
    pots.dup.each_index do |i|
        pots[i] = notes[get_key(old_pots, i+2)]
    end

    left = [notes[get_key(old_pots, 0)], notes[get_key(old_pots, 1)]]
    right = [notes[get_key(old_pots, old_pots.size-2)], notes[get_key(old_pots, old_pots.size-1)]]
    if left != ['.', '.']
        pots = left + pots
        start_idx -= 2
    end
    if right != ['.', '.']
        pots = pots + right
    end
end

p pots.each_with_index.map {|p, i| p == '#' ? i + start_idx : 0}
