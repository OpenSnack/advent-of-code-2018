# today we learned that concatenating big arrays is slow

PUZZLE_INPUT = 327901

recipes = [3, 7]
elf0 = 0
elf1 = 1
last_n = [nil] * PUZZLE_INPUT.digits.size

while true
    elf0 = (elf0 + recipes[elf0] + 1) % recipes.size
    elf1 = (elf1 + recipes[elf1] + 1) % recipes.size
    new_recipes = (recipes[elf0] + recipes[elf1]).digits.reverse
    new_recipes.each do |r|
        recipes.push(r)
        last_n.shift
        last_n.push(r)
        if last_n.join.to_i == PUZZLE_INPUT
            p recipes.size - PUZZLE_INPUT.digits.size
            exit
        end
    end
end
