using Test

function hex_to_binary(data::String)
    reduce(vcat, reverse.(digits.(parse.(Int, collect(data), base=16), base=2, pad=4)))
end
frombinary(x) = parse(Int, join(x), base=2)
@test frombinary([1 0]) == 2
@test frombinary([1 1 0]) == 6
@test frombinary(hex_to_binary("FFA")) == 4090
const data = hex_to_binary(readline("data/day16"))

function four(data)
    output = Vector{Int64}()
    for i in 1:5:length(data)
        push!(output, data[i+1:i+4]...)
        if data[i] == 0 return output, i+4 end # Packet end
    end
end
@test four([1 0 1 1 1 1 1 1 1 0 0 0 1 0 1 0 0 0]) == (Vector{Int64}([0,1,1,1,1,1,1,0,0,1,0,1]), 15)

function calculate(data, ptype)
        if ptype == 0 f = +
        elseif ptype == 1 f = *
        elseif ptype == 2 f = min
        elseif ptype == 3 f = max
        elseif ptype == 5 f = >
        elseif ptype == 6 f = <
        elseif ptype == 7 f = ==
        end
        outputs = reverse(digits(reduce(f, data), base=2))
end

@test calculate([55, 100], 0) == digits(155, base=2) |> reverse
@test frombinary(calculate([6, 9], 1)) == 54
@test calculate([55, 10, 33], 2) == digits(10, base=2) |> reverse
@test calculate([55, 10, 33], 3) == digits(55, base=2) |> reverse
@test calculate([55, 10], 5) == digits(1, base=2)  |> reverse
@test calculate([55, 10], 6) == digits(0, base=2) |> reverse
@test calculate([55, 10], 7) == digits(0, base=2) |> reverse
@test calculate([55, 55], 7) == digits(1, base=2) |> reverse

function packet(data::Array)
    outputs = Vector{Int64}()
    version, ptype, seek = frombinary(data[1:3]), frombinary(data[4:6]), 7
    if ptype == 4
        out, i = four(data[seek:end])
        push!(outputs, out...)
        seek += i
    else
        if data[seek] == 1
            # mode 1, next 11 bits indicate the number of subpackets contained in packet
            num_packets = frombinary(data[seek+1:seek+11])
            seek += 12
            for _ in 1:num_packets
                out, i = packet(data[seek:end])
                push!(outputs, frombinary(out))
                seek += i - 1
            end
        else
            # mode is 0, next 15 bits indicate total length in bits of subpackets
            len = frombinary(data[seek+1:seek+15])
            seek += 16
            stopat = seek + len
            while seek < stopat
                out, i = packet(data[seek:end])
                push!(outputs, frombinary(out))
                seek += i - 1
            end
        end
        outputs = calculate(outputs, ptype)
    end
    outputs, seek
end

tpack(hex) = frombinary(packet(hex_to_binary(hex))[1])
@test tpack("D2FE28") == 2021
@test tpack("C200B40A82") == 3
@test tpack("880086C3E88112") == 7
@test tpack("CE00C43D881120") == 9
@test tpack("D8005AC2A8F0") == 1
@test tpack("F600BC2D8F") == 0
@test tpack("9C005AC2F8F0") == 0
@test tpack("9C0141080250320F1802104A08") == 1
@test tpack("04005AC33890") == 54
println(frombinary(packet(data)[1]))