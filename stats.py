import os

pwd_path = os.path.dirname(os.path.realpath(__file__))

day_file_endings = [{".kk"}, {}, {}]
day_dirs = [pwd_path + "/day{}".format(x+1) for x in range(0, 25)]
days_data = []

def files_in(directory):
    for file in os.listdir("/mydir"):
        if file.endswith(".txt"):
            print(os.path.join("/mydir", file))

def lines_in_file():
    # TODO: implement this
    pass

# NOTE: each day should have a "run" script
def run_day(dir):
    # TODO: implement this
    pass

# -------------------------------------------------------------- #
# calc total line numbers 

for dir, endings in zip(day_dirs, day_file_endings):
    current_data = {}
    for file in files_in(dir):
        if "." + file.split(".")[-1] in endings:
            current_data["lines"] += lines_in_file(file)
            current_data["files"] +=  1
    days_data.push(current_data)

# -------------------------------------------------------------- #
# calc time 

TIMES = 3

runtimes = []
for i in range(0, TIMES):
    # TODO: implement this
    
    # start timer
    for dir in day_dirs:
        run_day

    # end timer

# TODO: calculate estimated error bounds.
