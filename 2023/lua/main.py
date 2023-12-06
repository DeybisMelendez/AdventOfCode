# https://adventofcode.com/2023/day/5

from operator import itemgetter
import sys

FILE = '05input.txt'

# 1. part - What is the lowest location number that corresponds to any of the initial seed numbers?
with open(FILE) as f:
    seeds = list(map(int, f.readline().split()[1:]))
    f.readline()  # skip first header
    f.readline()  # skip empty line
    maps = []
    map_ranges = []

    for line in f:
        if line == '\n':
            maps.append(map_ranges)
            map_ranges = []
            next(f)  # skip next header
        else:
            map_ranges.append(tuple(map(int, line.split())))
    if map_ranges:  # add the last mapping if it exists
        maps.append(map_ranges)

    # apply mappings for each seed
    lowest_location = sys.maxsize
    for s in seeds:
        for map_ranges in maps:
            for destination_start, source_start, length in map_ranges:
                # if seed is in range of the mapping
                if source_start <= s <= source_start + length - 1:
                    s = destination_start + s - source_start
                    break

        # keep only tle lowest location
        lowest_location = min(s, lowest_location)

    print(lowest_location)

# 2. part - What is the lowest location number that corresponds to any of the initial seed numbers?


def map_seed(s, m):
    destination_start, source_start, _ = m
    return destination_start + s - source_start


def map_seed_range(seed_range, map_ranges):
    seed_ranges = []
    seed_start, seed_end = seed_range[0], seed_range[1]

    for m in map_ranges:
        source_start, source_end = m[1], m[1] + m[2] - 1

        overlap_start = max(seed_start, source_start)
        overlap_end = min(seed_end, source_end)

        # if overlap exists
        if overlap_start <= overlap_end:
            # keep the seed range before ovelap untouched
            if seed_start <= overlap_start - 1:
                seed_ranges.append((seed_start, overlap_start - 1))

            # map range
            seed_ranges.append(
                (map_seed(overlap_start, m), map_seed(overlap_end, m)))

            # cut off already mapped seed ranges
            if overlap_end + 1 <= seed_end:
                seed_start = overlap_end + 1
            else:
                # empty seed range left
                seed_start = sys.maxsize
                break

    # if we have some seed range left
    if seed_start <= seed_end:
        seed_ranges.append((seed_start, seed_end))

    return seed_ranges


with open(FILE) as f:
    seeds = list(map(int, f.readline().split()[1:]))
    f.readline()  # skip first header
    f.readline()  # skip empty line
    maps = []
    map_ranges = []

    for line in f:
        if line == '\n':
            map_ranges.sort(key=itemgetter(1))  # sort by source range start
            maps.append(map_ranges)
            map_ranges = []
            next(f)  # skip next header
        else:
            map_ranges.append(tuple(map(int, line.split())))
    if map_ranges:  # add the last mapping if it exists
        map_ranges.sort(key=itemgetter(1))  # sort by source range start
        maps.append(map_ranges)

    # transform seed input into seed ranges
    seed_ranges = [(seeds[i], seeds[i] + seeds[i + 1] - 1)
                   for i in range(0, len(seeds), 2)]

    # apply mappings for each seed
    for map_ranges in maps:
        new_seed_ranges = []  # each seed range can be mapped to multiple seed ranges
        for seed_range in seed_ranges:
            new_seed_ranges += map_seed_range(seed_range, map_ranges)
        seed_ranges = new_seed_ranges

    # the minimum starting point within the ranges of seed values
    lowest_location = min(seed_range[0] for seed_range in seed_ranges)
    print(lowest_location)
