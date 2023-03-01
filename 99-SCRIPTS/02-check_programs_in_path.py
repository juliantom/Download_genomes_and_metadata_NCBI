#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""This script will check if a program is present in the environment/PATH.
    It requires a 'pgrogram name' as input and returns wether the program(s) were found 'YES/NO'!"""

import argparse
# Explanation message 
msg = "This program checks if a program(s) is present (in the PATH)"
parser = argparse.ArgumentParser(description = msg)

group = parser.add_mutually_exclusive_group()

group.add_argument("-p","--program", help="A program name or list of program names (separated by comma).", nargs="+", type=str)
group.add_argument("-l","--list_programs", help="A text file containing program names (one per line).", type=argparse.FileType('r'))

args = parser.parse_args()

my_test = "list_programs" in args

if my_test == False:
    args_list = args.program[0]
    args_list_split = args_list.split(',')
else:
    args_list = args.list_programs.readlines()

print(args_list)
#
for line in args_list:
    numbers = line.split(", ")

    for number in numbers:
        number = number.replace("\n", "")

        print(number)