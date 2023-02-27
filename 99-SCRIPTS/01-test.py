#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""This is a awesome
        python script!"""

print ("")
print ("START")
print ("-------------------------")

import argparse
# Explanation message 
msg = "A test program v2."
parser = argparse.ArgumentParser(description = msg)

parser.add_argument("-i","--input", help="Input file.", default="First random string.", required=True)
parser.add_argument("-m","--modifier", help="Conditional modifier.", required=False)
parser.add_argument("-e","--external_file", help="External file. Required.", required=False)
parser.add_argument("-v","--value", help="Value (integer)", required=False, type=int)
parser.add_argument("-vf","--value_float", help="Value (float)", required=False, type=float)
parser.add_argument("-o","--ouput", help="Output file.", required=True)

args = parser.parse_args()

# 
print("Input file =",args.input)
print("Modifier =",args.modifier)
print("External data =",args.external_file)
print("Value (integer) =",args.value)
print("Value (float) =",args.value_float)
print("Output file =",args.ouput)

#
print ("")
config = vars(args)
print("My config variables =",config)
print ("")
print ("-------------------------")
print ("END")
print ("")
