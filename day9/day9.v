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

	width := input.split("\n")[0].len
	height := input.split("\n").len
	mut num_list := input.replace("\n", "").split("").map(fn (x string) int {return x.int()})

	for y in 0..height {
		for x in 0..width {
			mut items := []int{}
			if x+1 + y * width < width * height && x+1 + y * width > 0 {
				items << num_list[x+1 + y * width]
			}

			if x-1 + y * width < width * height && x-1 + y * width > 0 {
				items << num_list[x-1 + y * width]
			}

			if x + (y+1) * width < width * height && x + (y+1) * width > 0 {
				items << num_list[x + (y+1) * width]
			}

			if x + (y-1) * width < width * height && x + (y-1) * width > 0 {
				items << num_list[x + (y-1) * width]
			}

			mut sum_items := 0
			for i in items {
				if i > num_list[x + y * width] {
					sum_items += 1
				}
			}

			if sum_items == items.len {
				final += num_list[x + y * width] + 1
			}

		}
	}
	println("part1: $final")
}

fn in_basin(mut current_basin &int, mut checked &map[string]bool, num_list []int, x int, y int, width int, height int) {
	if "$x,$y" in checked || num_list[x + y * width] == 9 {
		return
	} else {
		checked["$x,$y"] = true
		current_basin += 1
	}

	if x % width != width-1 && (x+1 + y * width) < width * height && x+1 + y * width > 0 {
		in_basin(mut &current_basin, mut checked, num_list, x+1, y, width, height)
	}
	if x % width != 0 && (x-1 + y * width) < width * height && x-1 + y * width > 0 {
		in_basin(mut &current_basin, mut checked, num_list, x-1, y, width, height)
	}
	if y != height-1 && (x + (y+1) * width) < width * height && x + (y+1) * width > 0 {
		in_basin(mut &current_basin, mut checked, num_list, x, y+1, width, height)
	}
	if y != 0 && (x + (y-1) * width) < width * height && x + (y-1) * width > 0 {
		in_basin(mut &current_basin, mut checked, num_list, x, y-1, width, height)
	}
}

fn part2(input string) {
	width := input.split("\n")[0].len
	height := input.split("\n").len
	mut num_list := input.replace("\n", "").split("").map(it.int())

	mut checked := map[string]bool{}
	mut basin_sizes := []int{}

	for y in 0..height {
		for x in 0..width {
			if "$x,$y" in checked || num_list[x + y * width] == 9 {
				// skip node
			} else {
				mut current_basin := 1 // create a new basin
				checked["$x,$y"] = true

				if x % width != width-1 && x+1 + y * width < width * height && x+1 + y * width > 0 {
					in_basin(mut current_basin, mut &checked, num_list, x+1, y, width, height)
				}
				if x % width != 0 && x-1 + y * width < width * height && x-1 + y * width > 0 {
					in_basin(mut current_basin, mut &checked, num_list, x-1, y, width, height)
				}
				if y != height-1 && x + (y+1) * width < width * height && x + (y+1) * width > 0 {
					in_basin(mut current_basin, mut &checked, num_list, x, y+1, width, height)
				}
				if y != 0 && x + (y-1) * width < width * height && x + (y-1) * width > 0 {
					in_basin(mut current_basin, mut &checked, num_list, x, y-1, width, height)
				}

				basin_sizes << current_basin
			}

		}
	}

	basin_sizes.sort(a > b)

	println("part2: ${basin_sizes[0] * basin_sizes[1] * basin_sizes[2]}")
}