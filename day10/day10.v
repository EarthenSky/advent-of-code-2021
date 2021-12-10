import os

fn main() {
	input := os.read_file('input') or {
		println("open file failed")
		return
	}
	part1(input)
	part2(input)
}

fn part1(input string) {
	mut final := 0 
	
	mut otype := {
		')': 0, '(': 0,
		']': 1, '[': 1,
		'}': 2, '{': 2,
		'>': 3, '<': 3,
	}

	mut isopen := {
		')': false, ']': false, '}': false, '>': false,
		'(': true, '[': true, '{': true, '<': true,
	}

	mut corrupted := {
		')': 0,
		']': 0,
		'}': 0,
		'>': 0,
	}

	for line in input.split("\n") {
		mut stack := []byte{}

		for char in line {
			if isopen[char.ascii_str()] {
				stack << char
			} else if !isopen[char.ascii_str()] {
				if otype[stack.last().ascii_str()] == otype[char.ascii_str()] {
					stack.pop()
				} else {
					corrupted[char.ascii_str()] += 1
					break
				}
			}
		}
	
	}

	final += corrupted[')'] * 3
	final += corrupted[']'] * 57
	final += corrupted['}'] * 1197
	final += corrupted['>'] * 25137

	println("part1: $final")
}

fn part2(input string) {
	mut final := []u64{}
	
	mut otype := {
		')': 0, '(': 0,
		']': 1, '[': 1,
		'}': 2, '{': 2,
		'>': 3, '<': 3,
	}

	mut isopen := {
		')': false, ']': false, '}': false, '>': false,
		'(': true, '[': true, '{': true, '<': true,
	}

	mut score := {
		'(': 1,
		'[': 2,
		'{': 3,
		'<': 4,
	}

	for line in input.split("\n") {
		mut stack := []byte{}

		mut bad := false
		for char in line {
			if isopen[char.ascii_str()] {
				stack << char
			} else if !isopen[char.ascii_str()] {
				if otype[stack.last().ascii_str()] == otype[char.ascii_str()] {
					stack.pop()
				} else {
					bad = true
					break // discard
				}
			}
		}
	
		mut tmp := u64(0)
		if !bad {
			for item in stack.reverse() {
				tmp *= 5
				tmp += u64(score[item.ascii_str()])
			}
			final << tmp
		}
	}

	final.sort()

	println("part2: ${final[final.len/2]}")
}