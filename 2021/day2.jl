textlines = readlines("data/day2")
textlines = map(x->split(x, limit=2), textlines)
commands = map(x->x[1], textlines)
amplitudes = map(x->parse(Int64, x[2]), textlines)

function part1(commands::Array, amplitudes::Array)
    x, y = 0, 0
    for (cmd, amp) in zip(commands, amplitudes)
        if cmd == "forward"
            x += amp
        elseif cmd == "down"
            y += amp
        elseif cmd == "up"
            y -= amp
        end
    end
    x * y
end
println(part1(commands, amplitudes))


function part2(commands, amplitudes)
    aim, x, y = 0,0,0
    for (cmd, amp) in zip(commands, amplitudes)
        if cmd == "forward"
            x += amp
            y += (aim * amp)
        elseif cmd == "down"
            aim += amp
        elseif cmd == "up"
            aim -= amp
        end
    end
    x * y
end

println(part2(commands, amplitudes))