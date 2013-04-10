#!/usr/bin/env python
import os
import sys
import getopt

# Resolve arguments
short_opts='d:afh'
long_opts=['depth=','files=']
opts, extraparams = getopt.getopt(sys.argv[1:], short_opts, long_opts) 

max_depth=-1
all=0
show_files=0
for o,p in opts:
    if o in ['-d', '--depth']:
	max_depth=int(p)
    if o in ['-f']:
	show_files=1
    if o in ['-h']:
	show_files=0
    if o in ['--files']:
	show_files=p
    if o in ['-a']:
	all=1

#print 'ls -R ' + str(depth)

#ls_return=os.popen("ls -R")
#print ls_return

#Setup top directory path if supplied
top_dirs='.'
if extraparams:
    top_dirs=extraparams

def print_prefix(num, string):
    i=0
    result=""
    while i<num:
	#result=result+"--"
	result=result+"  "
	i=i+1
    #print " |" + result + string
    print result + "|" + string

def one_directory(top,depth):
    num_files=0
    # Get file tree
    for f_or_d in os.listdir(str(top)):
	#print str(depth) + ' ' +f_or_d
	full_file=os.path.join(top,f_or_d)
	if os.path.isdir(full_file):
	    if all or not f_or_d.startswith('.'):
		print_prefix(depth+1, "--"+f_or_d + ":")
		#print max_depth, depth+1, depth<max_depth
		if max_depth<0 or depth+1<=max_depth: 
		    one_directory(full_file , depth+1)
	else:
	    num_files=num_files+1
    if show_files and num_files is not 0:
	print_prefix(depth+1, "++ " + str(num_files)+ " files")

#Loop over each top directory given
for top in top_dirs:
    if str(top)==".":
	print os.getcwd() +":"
    else:
	print top+":"
    one_directory(top,0)
    #print os.listdir(top)
