#!/usr/bin/env python
# -*- coding: utf-8 -*-
# -*- mode: python -*-

import os
import math

__author__ = "Allan Bailey, abailey@admob.com"
TMPDIR = '/var/tmp/graphite.counter_delta'


def load_last_value(metric):
    if not os.path.exists(TMPDIR):
        um = os.umask(0)
        os.makedirs(TMPDIR)
        os.umask(um)
        return None
    infile = '/'.join([TMPDIR, metric])
    if os.path.exists(infile):
        return open(infile).read()
    return None
    

def save_last_value(line):
    if line:
        metric, value, ts = line.split()
        outfile = '/'.join([TMPDIR, metric])
        open(outfile, 'w').write(line)
    

def calc_delta(current, prev):
    metric1, value1, ts1 = current.split()
    metric2, value2, ts2 = prev.split()
    if metric1 != metric2:
        return None
    for counter in metric1.split('.'):
        if counter.startswith('_counter'):
            break
    else:
        return None 

    if counter.endswith('64'):
        size = 64
    elif counter.endswith('32'):
        size = 32
    else: # what?
        return None
    boundary = 2**size

    value1 = float(value1)
    value2 = float(value2)

    # try to catch rollovers
    delta = value1 - value2
    if delta < 0.0:
        # value1 < value2, probable rollover.
        delta += boundary 

    try:
        newmetric = metric1.replace(counter, '_delta')
    except ValueError:
        return None
    line = "%s %s %s\n" % (newmetric, delta, ts1)
    return line


def process(line):
    """process 1 line generating delta of counter.
    """
    result = None
    try:
        metric, value, timestamp = line.split()
    except ValueError, er:
        return result

    if '._counter' in metric:
        # if we have a previous value, load it.
        prev = load_last_value(metric)
        # if no previous value, save this one and return
        # a delta of 0.
        if prev is None:
            prev = line
        r = calc_delta(line, prev)
        save_last_value(line)
        if r:
            return r

    return result
