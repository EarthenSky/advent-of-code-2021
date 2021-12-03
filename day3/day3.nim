import sugar

import std/strutils
import std/sequtils

proc part1(input: string) =
    var most_common_list: array[0..11, int] # why does typedef include size... I guess b/c array? just a bit inconsistent...
    for line in input.splitLines():
         for i in 0..line.len-1:
            most_common_list[i] += parseInt($line[i])

    var most_common = ""
    var least_common = ""
    for item in most_common_list:
        if float(item) > input.splitLines().len / 2:
            most_common = most_common & "1"
            least_common = least_common & "0"
        else:
            most_common = most_common & "0"
            least_common = least_common & "1"

    echo "part1: ", most_common.parseBinInt() * least_common.parseBinInt()

# most common
proc mc(lines: seq[string], i: int): char =
    var count = 0
    for line in lines:
        count += parseInt($line[i])

    if float(count) >= (lines.len/2): '1' else: '0'
    
proc part2(input: string) =
    var lst = input.splitLines()
    var lst2 = input.splitLines()

    var i = 0
    var mmc: char
    while lst.len > 1:
        mmc = mc(lst, i)
        lst = filter(lst, x => (x[i] == mmc))
        i += 1

    i = 0
    while lst2.len > 1:
        mmc = mc(lst2, i)
        lst2 = filter(lst2, proc(x: string): bool = (x[i] != mmc))
        i += 1

    echo "part2: ", lst[0].parseBinInt() * lst2[0].parseBinInt()

let input = readFile("input").strip()
part1 input
part2 input #NOTE: a lot of the difficulty with this problem was the difficulty of knowing function names? 
