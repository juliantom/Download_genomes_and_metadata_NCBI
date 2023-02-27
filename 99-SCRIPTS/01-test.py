#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""This is a awesome
        python script!"""


import argparse

parser = argparse.ArgumentParser(description='A test program.')

parser.add_argument("-p", "--print_string", help="Prints the supplied argument.", default="A random string.")

args = parser.parse_args()

print(args.print_string)