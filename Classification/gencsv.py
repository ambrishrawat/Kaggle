import csv
def csv2csv(ifile):
	ilist = ifile.readlines()
	ilist = [i.strip().split() for i in ilist]
	ilist = ilist[1:-1]
	new_list = []
	for i in ilist:
		temp = i[-1]
		print temp
		if temp[0] == '*':
			new_list.append(i[0]+','+str(float(temp[1:])))
		else:
			new_list.append(i[0]+','+str(float(temp)))

	r = 'Point_ID,Output\n'
	r += '\n'.join(new_list)
	return r

if __name__ == '__main__':
	import argparse
	parser = argparse.ArgumentParser(description='Format the Weka output to a submittable file.')
	parser.add_argument('--ifile', type=str, default='./Exp3/output.csv', help='Address to the Weka output file')
	parser.add_argument('--ofile', type=str, default="./Exp3/output_formatted.csv", help='Address of the output file')
	args = parser.parse_args()
	ipath = args.ifile
	opath = args.ofile
	with open(ipath,'r') as ifile:
		csvstr = csv2csv(ifile)
	with open(opath,'w') as ofile:
		ofile.write(csvstr)
