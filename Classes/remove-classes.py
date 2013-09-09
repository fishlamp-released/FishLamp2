#!/usr/bin/python

import sys
import os
import shutil

from os.path import join, dirname
from os import listdir, rmdir
from shutil import move

def moveup(dir) :
    parent = os.path.dirname(dir);
    for fn in listdir(dir):
        move(join(dir, fn), join(parent, fn));

def recurseit(path):
    for fn in os.listdir(path):
        dirpath = join(path, fn);
        if os.path.isdir(dirpath):
            if "Classes" in fn:
                moveup(dirpath);

                files = os.listdir(dirpath)
                if len(files) == 0:
                    print "Removing empty folder:", dirpath
                    os.rmdir(dirpath)
            else:
                recurseit(dirpath);

recurseit(os.getcwd())

