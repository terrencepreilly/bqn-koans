# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.

"""A quick utility to display which primitives have been introduced when.

This should be called from the root of the git repository. It displays
primitives in increasing order of occurrence, and shows how often each
primitive has been seen in each file. The files are listed in order they
appear in the koans. Ideally, then, we want to see multiple uses of each verb
where it first occurs, and have them reintroduced at intervals roughly
matching the forgetting curve, at a pace which we estimate people will go
through the koans.

"""

from collections import defaultdict
import itertools
import math
import os

PRIMITIVES = '+-×÷⋆√⌊⌈∧∨¬|≤<>≥=≠≡≢⊣⊢⥊∾≍⋈↑↓↕»«⌽⍉/⍋⍒⊏⊑⊐⊒∊⍷⊔!˙˜∘○⊸⟜⊘◶⌾⎊˘¨⌜⁼´˝`'

def get_file_contents(filename):
    with open(filename, 'r') as fin:
        contents = fin.read()
    return contents

def get_koans():
    cont = get_file_contents('contemplate.bqn')
    koans_list_start = cont.index('koans ← ⟨')
    koans_list_end = cont.index('⟩', koans_list_start)
    koans = [
      x.replace('"', '').strip()
      for x in cont[koans_list_start:koans_list_end - 1].split('\n')[1:]
    ]

    basedir = os.path.join(os.getcwd(), 'koans')
    return [os.path.join(basedir, x + '.bqn') for x in koans]


def get_primitive_occurences(filename):
    cont = get_file_contents(filename)
    data = dict()
    for primitive in PRIMITIVES:
        data[primitive] = cont.count(primitive)
    return {
      key: value
      for key, value in data.items()
      if value > 0
    }

def get_table(filenames_and_occurrences):
    all_primitives = set(
        itertools.chain(*[o.keys() for _, o in filenames_and_occurrences])
    )

    # Count the primitives first, so that we can list them in order
    # of decreasing frequency.
    primitive_count = defaultdict(lambda: 0)
    for _, occurrences in filenames_and_occurrences:
        for primitive in all_primitives:
            primitive_count[primitive] += occurrences.get(primitive, 0)

    ordered_primitives = [
      x[0] for x in sorted(primitive_count.items(), key=lambda x: x[1], reverse=True)
    ]

    longest_filename = max([len(filename) for filename, _ in filenames_and_occurrences])
    header = [' ' * (longest_filename)]
    primitive_widths = dict()
    for primitive in ordered_primitives:
        count = primitive_count[primitive]
        width = math.floor(math.log10(count)) + 1
        primitive_widths[primitive] = width
        header.append(primitive.rjust(width))
    header = ' '.join(header)

    table = [header]
    for filename, occurrences in filenames_and_occurrences:
        row = [filename.ljust(longest_filename)]
        for primitive in ordered_primitives:
            row.append(
                str(occurrences.get(primitive, 0) or ' ').rjust(primitive_widths[primitive])
            )
        table.append(' '.join(row))

    return '\n'.join(table)


if __name__ == '__main__':
    koans = get_koans()
    print(
        get_table([
            (os.path.basename(koan), get_primitive_occurences(koan))
            for koan in koans
        ])
    )
