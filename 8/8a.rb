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

def get_meta_sum(node)
    node.children.reduce(0) {|s, node| s + get_meta_sum(node)} + node.metadata.sum
end

input = File.open('8-input.txt').read.strip.split.map &:to_i

p get_meta_sum(Node.new(input))
