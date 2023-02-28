#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""This script will check if a program is present in the environment/PATH.
    It requires a 'pgrogram name' as input and returns wether the program(s) were found 'YES/NO'!"""

import argparse
# Explanation message 
msg = "This program checks if a prgitogram(s) is present (in the PATH)"
parser = argparse.ArgumentParser(description = msg)

parser.add_argument("-p","--program", help="A program name or list of program names (separated by comma).", required=True, nargs="+", type=str)

args = parser.parse_args()
args_list = args.program[0]
args_list_split = args_list.split(',')

def is_tool(name):
    """Check whether `name` is on PATH and marked as executable."""

    # from whichcraft import which
    from shutil import which

    return which(name) is not None

print("")
print("Checking if program(s) are in the $PATH...")
print("------------------------------")
num_programs = len(args_list_split)

print("1) List of programs :", args_list_split)
print("   Total programs:", num_programs)

# Count items in list of programs (iterations)
count = 0
for i in args_list_split:
    check_is_tool = is_tool(i)
    count += 1
    if check_is_tool == False:
        check_is_tool = "NO"
    else:
        check_is_tool = "YES"
    #print(count + ")" + " Program", "'" + i + "'" + " found:", check_is_tool)
    print("   -" + "Found", "(" + str(count) + "/" + str(num_programs) + "):", check_is_tool, "(" + i + ")" )

print("------------------------------")
print("DONE")
print("")