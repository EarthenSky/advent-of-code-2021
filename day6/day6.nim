import sugar

import std/math # for sum

import std/strutils
import std/sequtils

proc sim(input: string, cycles: int): int =
    var f = [0, 0,0,0,0, 0,0,0,0]

    for v in input.split(","):
        f[v.parseInt()] += 1

    for cy in 1..cycles:
        let zeros = f[0]
        f[0] = 0

        for i in 1..f.len-1:
            f[i-1] = f[i]

        f[8] = zeros
        f[6] += zeros

    return sum(f)

proc part1(input: string) =
    echo "part1: ", sim(input, 80)

proc part2(input: string) =
    echo "part2: ", sim(input, 256)

let input = readFile("input").strip()
part1 input
part2 input
