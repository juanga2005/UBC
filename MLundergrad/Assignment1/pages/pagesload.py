#Script to load the pages

from numpy import *

links={} #Creates a dictionary for the webpages
fnames=['angelinajolie.html','bradpitt.html','jenniferaniston.html','jonvoight.html',
'martinscorcese.html','robertdeniro.html']

for file in fnames:
	links[file]=[]
	f=open(file)
	for line in f.readlines():
		while True:
			p=line.partition('<a href="http://')[2]
			if p=='':
				break
			url,_,line=p.partition('\">')
			#print url
			#print _
			#print line
			links[file].append(url)
	f.close()

#Creating a cool graph
#import networkx as nx
#
#DG=nx.DiGraph();print DG;
#DG.add_nodes_from(fnames)


#Creating the transition matrix
from numpy import zeros
Nx=len(fnames)
T=matrix(zeros((Nx,Nx)))
