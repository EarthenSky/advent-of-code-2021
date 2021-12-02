import sugar

import std/strutils
import std/sequtils

proc part1(input: string) =
    # wtf error if int x is here...
    let lines = input.splitLines().map(x => parseInt x)

    var num = 0
    for i in 1..lines.len-1:
        if lines[i] > lines[i-1]:
            num += 1

    echo "part1: ", num

proc part2(input: string) =
    let lines = input.splitLines().map(x => parseInt x)
 
    var num = 0
    for i in 3..lines.len-1:
        if lines[i] > lines[i-3]:
            num += 1

    echo "part2: ", num

let input = readFile("input").strip()
part1 input
part2 input
