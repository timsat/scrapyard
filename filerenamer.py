#!/bin/python2.7
# -*- coding: utf-8 -*-
import os
import sys
import fnmatch
import re

reg = re.compile(r'(\([0-9]*\))\.[a-z0-9]*$')

def cmp_to_key(mycmp):
    'Convert a cmp= function into a key= function'
    class K:
        def __init__(self, obj, *args):
            self.obj = obj
        def __lt__(self, other):
            return mycmp(self.obj, other.obj) < 0
        def __gt__(self, other):
            return mycmp(self.obj, other.obj) > 0
        def __eq__(self, other):
            return mycmp(self.obj, other.obj) == 0
        def __le__(self, other):
            return mycmp(self.obj, other.obj) <= 0
        def __ge__(self, other):
            return mycmp(self.obj, other.obj) >= 0
        def __ne__(self, other):
            return mycmp(self.obj, other.obj) != 0
    return K

def filename_cmp(x, y):
    flag1 = reg.search(x) == None
    flag2 = reg.search(y) == None
    if flag1 != flag2:
        if flag1:
            return -1
        else:
            return 1
    else:
        return cmp(x, y)

infiles = []
for file in os.listdir('.'):
    if fnmatch.fnmatch(file, sys.argv[1]):
        infiles.append(file)

infiles = sorted(infiles, key=cmp_to_key(filename_cmp))
print(infiles)

i = int(sys.argv[2]) if len(sys.argv) > 2 else 1

new_names = []
matched = False
for file in infiles:
    f = reg.search(file)
    num = " {}".format(str(i))
    if f == None:
        name = file.split(".")
        new_name = name[0] + num + "." + name[1]
    else:
        matched = True
        new_name = file.replace(f.group(1), num)
    new_names.append(new_name)
    i += 1

if matched:
    print(zip(infiles, new_names))
    map(lambda x, y: os.rename(x, y), infiles, new_names)
else:
    print("No '(%d)' suffix found in the list. Nothing to rename")
