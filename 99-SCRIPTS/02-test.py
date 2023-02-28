#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""This script will check if a program is present in the environment/PATH.
    It requires a 'pgrogram name' as input and returns wether the program(s) were found 'Yes/No'!"""

import argparse
# Explanation message 
msg = "This program checks if a program is present (in the PATH)"
parser = argparse.ArgumentParser(description = msg)

parser.add_argument("-p","--program", help="A program name or list of program names (separated by comma).", required=True, nargs="+", type=str)

args = parser.parse_args()


# Function to check if command NCBI-datasets is in the PATH
def is_tool(name):
    """Check whether `name` is on PATH and marked as executable."""

    # from whichcraft import which
    from shutil import which

    return which(name) is not None

check_is_tool = is_tool(args.program)
if check_is_tool == False:
    check_is_tool = "NO"
else:
    check_is_tool = "YES"
# 
print("")
print("Checking if required program(s) are in the $PATH...")
print("------------------------------")
print("Program", "'" + args.program + "'" + " found:", check_is_tool)
####