defmodule Day4 do
    def part1(input) do
        [instructions | boards] = String.split(input, "\n\n")
        strings = String.split(instructions, ",")
        numbers = Enum.map(strings, fn x -> (case Integer.parse(x) do :error -> 0; {x, _} -> x end) end)
        boards = Enum.map(boards, fn b -> make_board(b) end)

        {winning_board, last_num} = play_bingo(boards, numbers)
        get_value(winning_board) * last_num
    end

    def play_bingo(_, numbers) when length(numbers) == 0 do
        {:none, :none}
    end

    def play_bingo(boards, numbers) do
        [top | new_numbers] = numbers
        
        new_boards = Enum.map(boards, fn board -> update_board(board, top) end)
        theboard = Enum.filter(new_boards, fn board -> board_wins(board) end) 
        if length(theboard) == 0 do
            play_bingo(new_boards, new_numbers)
        else
            [r|_] = theboard
            {r, top}
        end
    end

    def make_board(board_string) do
        cleaned_board = String.trim(String.replace(String.replace(board_string, "\n", " ") , "  ", " "))
        list_of_string = String.split(cleaned_board, " ")
        
        Enum.map(list_of_string, fn x -> (case Integer.parse(x) do :error -> 0; {x, _} -> x end) end)
    end

    def update_board(board, num) do
        Enum.map(board, fn v -> if v == num, do: v+1000, else: v end)
    end

    def board_wins(board) do
        h_wins = Enum.map(0..4, fn n -> hoz_wins(board, n * 5) end)
        v_wins = Enum.map(0..4, fn n -> vert_wins(board, n) end)
        Enum.any?(h_wins, fn x -> x end) or Enum.any?(v_wins, fn x -> x end)
    end

    def hoz_wins(list, start) do # not this though, well, not much...
        not Enum.any?(Enum.take(Enum.drop(list, start), 5), fn v -> not is_marked(v) end)
        #not Enum.any?(Enum.map(start..start+4, fn i -> not is_marked(Enum.at(list, i)) end))
    end

    def vert_wins(list, start) do # this is faster~!
        not Enum.any?(for v <- Enum.take_every(Enum.drop(list, start), 5), do: not is_marked(v))
        #not Enum.any?(for i <- start..24, rem(i-start, 5) == 0, do: not is_marked(Enum.at(list, i)))
    end

    def is_marked(val) do
        val >= 100
    end

    def get_value(board) do
        v_board = Enum.map(board, fn v -> if is_marked(v), do: 0, else: v end)
        Enum.reduce(v_board, 0, fn x, acc -> x + acc end)
    end

    # ----------------------------------------------------------------------- #
    
    def part2(input) do
        [instructions | boards] = String.split(input, "\n\n")
        strings = String.split(instructions, ",")
        numbers = Enum.map(strings, fn x -> (case Integer.parse(x) do :error -> 0; {x, _} -> x end) end)
        boards = Enum.map(boards, fn b -> make_board(b) end)

        {final_board, last_num} = play_bingo_elimination(boards, numbers, :none, :none)
        get_value(final_board) * last_num
    end 

    def play_bingo_elimination(boards, _, last_num, last_board) when length(boards) == 0 do
        {last_board, last_num}
    end

    def play_bingo_elimination(boards, numbers, _, _) do
        [top | new_numbers] = numbers
        
        new_boards = Enum.map(boards, fn board -> update_board(board, top) end)
        not_won_boards = Enum.filter(new_boards, fn board -> not board_wins(board) end) 

        if length(not_won_boards) == 0 do
            won_boards = Enum.filter(new_boards, fn board -> board_wins(board) end) 
            [did_win | _] = won_boards
            play_bingo_elimination(not_won_boards, new_numbers, top, did_win)
        else
            play_bingo_elimination(not_won_boards, new_numbers, top, :none)
        end
    end
end

f = File.read("input")
case f do
    {:ok, fs} -> IO.puts "part1: #{Day4.part1(fs)}\n" <> "part2: #{Day4.part2(fs)}\n"
    _ -> IO.puts "error, file could not be read"
end