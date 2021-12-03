defmodule Day3 do
    def part1(input) do
        # technically, I can solve this by using two pointers.
        lines = String.split(input, "\n")
        numbers = for i <- 1..lines.len-1, do: if lines[i] > lines[i-1], do: 1, else: 2
        List.foldl(numbers, 0, fn x, acc -> x + acc end)
    end

    def iter(p1, p2) do
        if __ do
        
        else 

        end 
    end

    def part2(input) do
        0
    end 
end

f = File.read("input")
case f do
    {:ok, fs} -> {
        IO.puts "part1: #{Day3.part1(fs)}"
        #IO.puts "part2: #{Day3.part2(fs)}"
    }
    _ -> IO.puts "error, file could not be read"
end

