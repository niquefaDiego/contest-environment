import os
import re
import requests
import sys
import subprocess

 
number = -1
if len(sys.argv) >= 2:
	number = sys.argv[1]
else:
	number = input()

print("contest number = " + number)
 
 
def ensure_dir(file_path):
# directory = os.path.dirname(file_path)
	if not os.path.exists(file_path):
		os.makedirs(file_path)

def parse_task(index):
	print("Parsing problem {0}".format(index) )
	r = requests.get("http://codeforces.com/contest/" + number + "/problem/" + index)
	s = r.text
	a = re.findall("Input</div><pre>.*?</pre>", s)
	b = re.findall("Output</div><pre>.*?</pre>", s)

	if (len(a) == 0):
		print ("Something went wrong...")
		sys.exit(0)

	assert(len(a) == len(b))
	for i in range(len(a)):
		a[i] = a[i][16:-6].replace('<br />', '\n')
		b[i] = b[i][17:-6].replace('<br />', '\n')
    
	print ( " -> %d samples" % len(a) )
	solution_folder = "_sol/cf/" + index
	cases_folder = solution_folder + "/cases"
	ensure_dir(cases_folder)

	for i in range(len(a)):
		f = open(cases_folder + "/" + str(i) + ".in","w+")
		f.write ( a[i] )
		f.close()
		f = open(cases_folder + "/" + str(i) + ".out","w+")
		f.write ( b[i] )
		f.close()

	print()
     
r = requests.get("http://codeforces.com/contest/" + number)
s = r.text
a = re.findall("/contest/" + number + "/problem/.", s)
a = sorted(list(set(a)))
for x in a:
	parse_task(x[-1])
