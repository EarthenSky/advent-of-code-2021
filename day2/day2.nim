import std/strutils
import std/sequtils

proc part1(input: string) =
    var depth, hoz = 0
    
    for line in input.splitLines():
        let items = line.split(" ")
        let (cmd, v) = (items[0], parseInt items[1])
        case cmd:
            of "forward": hoz += v
            of "down": depth += v
            of "up": depth -= v

    echo "part1: ", depth * hoz

proc part2(input: string) =
    var depth, hoz, aim = 0
    
    for line in input.splitLines():
        let items = line.split(" ")
        let (cmd, v) = (items[0], parseInt items[1])
        
        case cmd:
            of "forward":
                hoz += v; depth += aim * v
            of "down":
                aim += v
            of "up":
                aim -= v

    echo "part2: ", depth * hoz


let input = readFile("input").strip()
part1 input
part2 input
