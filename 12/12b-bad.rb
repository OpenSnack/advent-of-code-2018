# add at end: << (depending on distance away) + (0 or 1)
# add at start: n + next highest power of 2 (depending on distance away)
# get bit n: i[n] on int
# set bit n: i = i | (2 ^^ n)
# clear bit n: i = i & ~(1 << n)
# get range [m1..m2]: n >> m1 & ('1'*(m2-m1)).to_i(2)
#
# NOTE: these memes weren't dank enough but keep in mind that on my machine it should finish in about 69 days NICE

def input_to_bin(s)
    s.chars.map {|c| c == '#' ? '1' : '0'}.join.to_i(2)
end

def bit_range(n, r1, r2)
    n >> r1 & ('1'*(r2-r1+1)).to_i(2)
end

def set(n, bit)
    n | (2 ** bit)
end

def clear(n, bit)
    n & ~(1 << bit)
end

def add_start(n, val, offset=1)
    n + (val << (n.bit_length - 1 + offset))
end

def add_end(n, val, offset=1)
    (n << offset) + val
end

def trim(n)
    while n[0] == 0
        n = n >> 1
    end
    n
end

input = File.open('12-input.txt').readlines.map &:strip
pots_spec = input[0].split[2]
pots = input_to_bin(pots_spec)
notes = Hash[
    input[2..-1].map do |line|
        parts = line.split(' => ')
        [
            input_to_bin(parts[0]),
            parts[1] == '#' ? 1 : 0
        ]
    end
]

start = pots_spec.size - pots_spec.gsub(/^\.*/,'').size

50000000000.times do |tm|
    if tm % 10000 == 0
        p tm
    end
    old_pots = pots
    old_pots.bit_length.times do |bit|
        new_bit = notes[bit_range(old_pots, bit - 2, bit + 2)]
        if new_bit == 1
            pots = set(pots, bit)
        else
            pots = clear(pots, bit)
        end
    end

    len = pots.bit_length
    old_len = old_pots.bit_length
    start += old_len - len
    
    pots = add_start(pots, notes[bit_range(old_pots, old_len-2, old_len+2)], old_len - len + 1)
    need_offset = len == pots.bit_length ? 2 : 1
    pots = add_start(pots, notes[bit_range(old_pots, old_len-1, old_len+3)], need_offset + old_len - len + 1)

    start -= pots.bit_length - len

    pots = add_end(pots, notes[bit_range(old_pots, -3, 1)])
    need_offset = len == pots.bit_length ? 2 : 1
    pots = add_end(pots, notes[bit_range(old_pots, -4, 0)], need_offset)

    pots = trim(pots)
end

p pots.to_s(2).chars.each_with_index.map {|c, i| c == '1' ? c.to_i + start + i - 1 : 0}.sum
