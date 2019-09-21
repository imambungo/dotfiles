#!/usr/bin/env python3

import sys, os

# os.environ -> https://stackoverflow.com/a/4907053/9157799
# sys.path.insert -> https://stackoverflow.com/a/52328080/9157799
sys.path.insert(0, os.environ['HOME'] + '/Projects/CTF/ctf_script')
from python_script import *
print("Welcome")
