PUZZLE_INPUT = 327901

recipes = [3, 7]
elf0 = 0
elf1 = 1

while recipes.size < PUZZLE_INPUT + 10
    elf0 = (elf0 + recipes[elf0] + 1) % recipes.size
    elf1 = (elf1 + recipes[elf1] + 1) % recipes.size
    recipes += (recipes[elf0] + recipes[elf1]).digits.reverse
end

p recipes[-10..-1].map(&:to_s).join
