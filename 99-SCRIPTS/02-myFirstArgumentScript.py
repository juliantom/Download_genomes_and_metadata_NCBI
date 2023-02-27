#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""This is a awesome
        python script!"""
        
def is_tool(name):
    """Check whether `name` is on PATH and marked as executable."""

    # from whichcraft import which
    from shutil import which

    return which(name) is not None

which(wget) 