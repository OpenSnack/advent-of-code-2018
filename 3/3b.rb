fabric = Array.new(1000) { Array.new(1000, 0) }
claims = File.open('3-input.txt').readlines().map do |s|
    s = s.strip.split('@ ')
    coords, dims = s[1].split(': ')
    x, y = coords.split(',').map {|n| n.to_i}
    w, h = dims.split('x').map {|n| n.to_i}
    out = {
        claim: s[0].strip,
        x: x,
        y: y,
        w: w,
        h: h
    }
    out
end

claims.each do |c|
    (c[:x]...c[:x]+c[:w]).each do |m|
        (c[:y]...c[:y]+c[:h]).each do |n|
            fabric[m][n] += 1
        end
    end
end

claims.each do |c|
    overlapped = false
    (c[:x]...c[:x]+c[:w]).each do |m|
        (c[:y]...c[:y]+c[:h]).each do |n|
            if fabric[m][n] > 1
                overlapped = true
            end
        end
    end
    if !overlapped
        puts c[:claim]
        exit
    end
end
