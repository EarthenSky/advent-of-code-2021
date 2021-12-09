import os

// TODO: get newest compiler version & report these bugs

fn main() {
	input := os.read_file('input') or {
		println("open file failed")
		return
	}
	part1(input)
	part2(input)
}

fn custom_to_int(ch string, mapping map[string]string) int {
	if ch.len == 2 {
		return 1
	} else if ch.len == 4 {
		return 4
	} else if ch.len == 3 {
		return 7
	} else if ch.len == 7 {
		return 8
	} else if ch.len == 5 {
		if ch.contains(mapping['b']) {
			return 5
		} else if !ch.contains(mapping['f']) {
			return 2
		} else {
			return 3
		}
	} else {
		if !ch.contains(mapping['e']) {
			return 9
		} else if !ch.contains(mapping['c']) {
			return 6
		} else {
			return 0
		}
	}
}

// the first parens are for redeclaring types, which we'll accomplish via tags
// fn () name () type {}
fn part1(input string) {
	mut times := 0

	for line in input.split("\n") {
		halves := line.split(" | ")
		right := halves[1]
		right_list := right.split(" ")

		for item in right_list {
			if item.len == 2 || item.len == 3 || item.len == 4 || item.len == 7 {
				times += 1
			}
		}
	}

	println("part1: $times")
}

fn part2(input string) {
	mut sum := 0

	for line in input.split("\n") {
		halves := line.split(" | ")
		left := halves[0]
		right := halves[1]

		left_list := left.split(" ") // bug unused?
		right_list := right.split(" ")
		
		mut mapping := map[string]string{}

		mut two := string("")
		mut three := ""
		mut four := ""
		mut five := []string{}
		mut six := []string{}
		mut seven := ""
		
		for item in left_list {
			match item.len {
				2 {two = item}
				3 {three = item}
				4 {four = item}
				5 {five << item}
				6 {six << item}
				7 {seven = item}
				else {}
			}
		}
		
		mut four_poss := []string{}
		for ch in four {
			if !(three.contains(ch.ascii_str())) {
				four_poss << ch.ascii_str()
			}
		}

		mut eight_poss := []string{}
		for ch in seven {
			if !(four_poss.contains(ch.ascii_str())) && !(three.contains(ch.ascii_str())) {
				eight_poss << ch.ascii_str()
			}
		}

		mut nine_poss := ""
		for s in six {
			mut num := 0
			for ch in s {
				if four.contains(ch.ascii_str()) { // error for unnecesary syntax?
					num += 1
				}
			}

			if num != 3 {
				nine_poss = s
			}
		}
		
		six = six.filter(it != nine_poss)
		
		for ch in seven {
			if !(nine_poss.contains(ch.ascii_str())) {
				mapping['e'] = ch.ascii_str()
			}
		}
		
		for s in six {
			mut num := 0
			mut thech := ""
			for ch in two {
				if s.contains(ch.ascii_str()) {
					num += 1
					thech = ch.ascii_str()
				}
			}

			if num == 1 {
				mapping['f'] = thech
			} 
		}

		// NOTE: this is kinda inefficient now?
		mut zero_poss := ""
		for s in six {
			mut num := 0
			mut thech := ""
			for ch in two {
				if s.contains(ch.ascii_str()) {
					num += 1
					thech = ch.ascii_str()
				}
			}

			if num != 1 {
				zero_poss = s
				for ch in two {
					if ch.ascii_str() != mapping['f'] {
						thech = ch.ascii_str()
					}
				}
				mapping['c'] = thech
			}
		}

		for ch in zero_poss {
			if !(three.contains(ch.ascii_str())) && !(eight_poss.contains(ch.ascii_str())) {
				mapping['b'] = ch.ascii_str()
			}
		}

		sum += custom_to_int(right_list[0], mapping) * 1000
		sum += custom_to_int(right_list[1],mapping) * 100
		sum += custom_to_int(right_list[2],mapping) * 10
		sum += custom_to_int(right_list[3],mapping) * 1

	}

	println("part2: $sum")
}