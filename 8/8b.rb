class Node
    def initialize(nums)
        @size = 0
        @children = []
        @metadata = []

        self.build(nums)
    end

    def build(nums)
        offset = 2
        nums[0].times do |idx|
            child = Node.new(nums.drop(offset))
            @children.push(child)
            offset += child.size
        end
        @metadata = nums[offset...offset+nums[1]]
        @size = offset + @metadata.size
    end

    def value
        # p @metadata
        return @metadata.sum if @children.size == 0
        @metadata.map {|meta|
            if @children[meta-1].nil?
                0
            else
                @children[meta-1].value
            end
        }.sum
    end

    def children
        @children
    end

    def size
        @size
    end

    def metadata
        @metadata
    end
end

input = File.open('8-input.txt').read.strip.split.map &:to_i

p Node.new(input).value
