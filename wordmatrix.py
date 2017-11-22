import sys
import operator
import csv


keyword_file = open(sys.argv[1])
stopword_file = open(sys.argv[2])
wordcount_file = open(sys.argv[3])

def main():

	stopword_array = []
	for line in stopword_file :
		line = line.rstrip('\n')
		line = line.rstrip()
		stopword_array.append(line)

	keyword_array = []
	for line in keyword_file :
		line = line.rstrip('\n')
		line = line.rstrip()
		linedata = line.split(',')
		index = 1
		for word in linedata:
			#if index ==106:
				#print word
				#return 0
			temp = keyword(word,index)
			keyword_array.append(temp)
			index += 1

	ignoreindex = []
	for item in keyword_array:
		if item.name in stopword_array:
			ignoreindex.append(item.index)


	songcount = [[]]
	for line in wordcount_file:
		line = line.rstrip('\n')
		line = line.rstrip()
		eachsong = []
		linedata = line.split(',')
		for piece in linedata:
			piecetwo = piece.split(':')
			piece1 = piecetwo[0]
			if int(piece1) in ignoreindex:
				continue
			else:
				temp = wordcount(int(piece1),int(piecetwo[1]))
				eachsong.append(temp)
		songcount.append(eachsong)

	del songcount[0]

	union = []
	for eachitem in songcount:
		for item in eachitem:
			if item.wordid not in union:
				union.append(item.wordid)


	for eachitem in songcount:
		lyricsindex = []
		for item in eachitem:
			lyricsindex.append(item.wordid)
		for index in union:
			if index not in lyricsindex:
				eachitem.append(wordcount(index,0))

	union.sort()
	#print union 
	#return 0
	union_set = []
	tempindex = 0
	for item in union:
		union_set.append(unionword(tempindex,item))
		tempindex += 1

	for eachitem in songcount:
		eachitem.sort(key = operator.attrgetter('wordid'))

	outputmatrix = [[]]
	for index1 in union :
		for keyitem in keyword_array:
			if int(keyitem.index) == int(index1):
				outputmatrix[0].append(keyitem.name)
	for eachitem in songcount:
		singlevector = []
		for item in eachitem:
			singlevector.append(item.count)
		outputmatrix.append(singlevector)
	#del outputmatrix[0]
	print len(union)
	"""
	keywordindex = [171,258,15,565,351,150,612,680,176,165]
	for i in keywordindex :
		for unionitem in union_set:
			if int(unionitem.unionindex) == i :
				temp = unionitem.actualindex
				for item in keyword_array:
					if int(item.index)== int(temp):
						print item.name

	print '\n'
	keywordindex2 = [322,135,523,11,580,3,98,309,604,648]
	for i in keywordindex2 :
		for unionitem in union_set:
			if int(unionitem.unionindex) == i :
				temp = unionitem.actualindex
				for item in keyword_array:
					if int(item.index)== int(temp):
						print item.name

	keywordindex3 = [282,549,458,635,352,678,105,569,410,277]
	for i in keywordindex3 :
		for unionitem in union_set:
			if int(unionitem.unionindex) == i :
				temp = unionitem.actualindex
				for item in keyword_array:
					if int(item.index)== int(temp):
						print item.name """

		
	
	with open("matrixoutput.csv","w") as output:
		writer = csv.writer(output,lineterminator = '\n')
		writer.writerows(outputmatrix)
	
	


			
class unionword():
	unionindex = 0
	actualindex = ''
	def __init__(self, unionid, actualid):
		self.unionindex = unionid
		self.actualindex = actualid

class keyword():
	name = ''
	index = 1
	def __init__(self, name, index):
		self.name = name
		self.index = index

class wordcount():
	wordid = 1
	count = 0
	def __init__(self, wordid, count):
		self.wordid = wordid
		self.count = count


main()
