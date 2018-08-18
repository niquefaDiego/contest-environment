import os
import re
import requests
import sys
import subprocess
 
 
def ensureDir(file_path):
# directory = os.path.dirname(file_path)
	if not os.path.exists(file_path):
		os.makedirs(file_path)

def parseTask(casesFolder, contestId, probId):
	print("Parsing problem {0}".format(probId) )
	r = requests.get("http://codeforces.com/contest/" + contestId + "/problem/" + probId)
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
	ensureDir(casesFolder)

	for i in range(len(a)):
		f = open(casesFolder + "/" + str(i) + ".in","w+")
		f.write ( a[i] )
		f.close()
		f = open(casesFolder + "/" + str(i) + ".out","w+")
		f.write ( b[i] )
		f.close()

	print()


def main():
	contestFolder = sys.argv[1]
	contestId = sys.argv[2]
	if len(sys.argv) >= 4:
		probId = sys.argv[3]
	print(sys.argv)
	print("Contest " + contestId)     
	r = requests.get("http://codeforces.com/contest/" + contestId)

	i = 0
	probId = None
	while i < len(contestId) and not contestId[i].isdigit():
		i += 1
	if i < len(contestId):
		probId = contestId[i:]
		contestId = contestId[:i-1]

	problemsToParse = []
	if probId != None:
		problemsToParse = [probId]
	else:
		s = r.text
		problemsToParse = re.findall("/contest/" + contestId + "/problem/.", s)
		problemsToParse = sorted(list(set(problemsToParse)))

	for probId in problemsToParse:
		probId = probId[-1]
		problemFolder = contestFolder + "/" + probId
		casesFolder = problemFolder + "/cases"
		parseTask(casesFolder, contestId, probId)

main()