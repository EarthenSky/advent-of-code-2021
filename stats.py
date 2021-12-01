import os
import time

pwd_path = os.path.dirname(os.path.realpath(__file__))

main_files = ["day1.nim", "day2.nim", "day3.nim"]
days = ["day{}".format(x+1) for x in range(0, 25)]
days_data = []

def files_in(directory):
    for file in os.listdir("/mydir"):
        if file.endswith(".txt"):
            print(os.path.join("/mydir", file))

def lines_in_file(filename):
	return sum(1 for line in open(filename))

# -------------------------------------------------------------- #
# calc total line numbers 

for day, file in zip(days, main_files):
	current_data = {"day": day, "lines": 0, "files": 0}
   
	path = "{}/{}/{}".format(pwd_path, day, file)
 
	if not os.path.isfile(path):
		continue

	current_data["lines"] += lines_in_file(path)
	current_data["files"] += 1

	days_data.append(current_data)

	# ---------------------------------------------------------- #
	# calc time 

	print("\n### simulating {} ...".format(day))

	# TODO: calculate estimated error bounds.
	TIMES = 1

	current_data["times"] = []
	for i in range(0, TIMES):
		# NOTE: each day must have these scripts (after the fact is okay)
		run = "cd {}/{}/; ./run.sh".format(pwd_path, day)
		setup = "cd {}/{}/; ./setup.sh".format(pwd_path, day)

		os.system(setup)	

		start = time.monotonic_ns() 
		os.system(run)	
		elapsed = time.monotonic_ns() - start

		current_data["times"] += [elapsed]

	current_data["avg_time"] = sum(current_data["times"])/TIMES

# -------------------------------------------------------------- #
# output

US_TO_MS = 1 / (1000 * 1000)

for el in days_data:
	print("\n## output:")
	print("{}: {} lines across {} file(s)".format(el["day"], el["lines"], el["files"]))
	print("\ttook {}ms".format(el["avg_time"] * US_TO_MS))
	#print("\tpart2 took {}ms".format(el["avg_time1"]))

