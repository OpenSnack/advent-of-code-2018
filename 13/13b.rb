carts = {}

moves = {
    '>' => [1, 0],
    '<' => [-1, 0],
    '^' => [0, -1],
    'v' => [0, 1]
}

next_ints = {
    'left' => 'straight',
    'straight' => 'right',
    'right' => 'left'
}

turns = {
    '/' => {
        '>' => '^',
        '<' => 'v',
        '^' => '>',
        'v' => '<'
    },
    '\\' => {
        '>' => 'v',
        '<' => '^',
        '^' => '<',
        'v' => '>'
    },
    '+' => {
        '>' => {
            'left' => '^',
            'straight' => '>',
            'right' => 'v'
        },
        '<' => {
            'left' => 'v',
            'straight' => '<',
            'right' => '^'
        },
        '^' => {
            'left' => '<',
            'straight' => '^',
            'right' => '>'
        },
        'v' => {
            'left' => '>',
            'straight' => 'v',
            'right' => '<'
        }
    }
}

def get_new_dir(dir, type, turns, next_int=nil)
    if type == '+'
        return turns[type][dir][next_int]
    elsif ['/', '\\'].include? type
        return turns[type][dir]
    else
        return dir
    end
end

layout = File.open('13-input.txt').readlines.each_with_index.map do |line, y|
    line = line.chomp
    line.chars.each_with_index.map do |type, x|
        if ['^', 'v'].include? type
            carts[[x, y]] = {dir: type, next_int: 'left', steps: []}
            '|'
        elsif ['<', '>'].include? type
            carts[[x, y]] = {dir: type, next_int: 'left', steps: []}
            '-'
        else
            type
        end
    end
end

while carts.size > 1
    carts.keys.sort_by {|x, y| [y, x]}.each do |k|
        if carts[k]
            new_key = [k, moves[carts[k][:dir]]].transpose.map{|a| a.sum}
            if carts.key? new_key
                carts.delete(k)
                carts.delete(new_key)
            else
                tile_type = layout[new_key[1]][new_key[0]]
                carts[new_key] = carts[k]
                carts[new_key][:steps].push(new_key)
                carts[new_key][:dir] = get_new_dir(
                    carts[new_key][:dir],
                    tile_type,
                    turns,
                    carts[new_key][:next_int]
                )
                if tile_type == '+'
                    carts[new_key][:next_int] = next_ints[carts[new_key][:next_int]]
                end
                carts.delete(k)
            end
        end
    end
end

puts carts.keys[0].join(',')
