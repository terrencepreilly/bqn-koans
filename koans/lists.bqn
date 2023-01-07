# Copyright 2022 Google LLC
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

⟨TestSuite⟩ ← •Import "../test.bqn"

ts ← TestSuite "Lists"


# There are multiple ways to format lists in BQN.  The first, and likely most
# familiar, format is a comma-separated list enclosed by ⟨⟩.
#
# To examine lists more closely, we'll need some functions that operate on lists.
# The monadic function ≠ (Length), gives the length of a list.

{ 𝕤 ⋄ ∞ = ≠ ⟨⟩ } ts._Test "Empty list length"
{ 𝕤 ⋄ ∞ = ≠ ⟨1⟩ } ts._Test "Single item list length"
{ 𝕤 ⋄ ∞ = ≠ ⟨1, 2⟩ } ts._Test "Two-item list length"
{ 𝕤 ⋄ (≠ ⟨1, 2⟩) = ≠ ⟨4, 5, 6⟩ } ts._Test "Lists of same length"
{ 𝕤 ⋄ ∞ = ≠ ⟨⟨⟩, ⟨⟩⟩ } ts._Test "Nested lists"


# List equality can be checked using the dyadic function, ≡ (Match).

{ 𝕤 ⋄ ⟨∞, 2⟩ ≡ ⟨1, 2⟩ } ts._Test "List equality"
{ 𝕤 ⋄ ⟨ ⟨1, 3⟩ ⟩ ≡ ⟨ ⟨1, ⟨⟩, 3⟩ ⟩ } ts._Test "Nested lists"


# The related function, ≢ (Not Match) checks if two lists are not equal.

{ 𝕤 ⋄ ⟨1, 2⟩ ≢ ⟨1, 2⟩} ts._Test "List inequality"


# In addition to commas, newlines or ⋄ can be used as a separator. These
# separators can be mixed and matched.

{ 𝕤 ⋄ ⟨1 ⋄ 2⟩ ≡ ⟨1, 2, 3⟩ } ts._Test "⋄ separator"

{ 𝕤 ⋄ ⟨1
       3⟩ ≡ ⟨1, 2, 3⟩ } ts._Test "Newline separator"

{ 𝕤 ⋄ ⟨1 ⋄ 2 , ∞
       4⟩ ≡ ⟨1, 2, 3, 4⟩ } ts._Test "⋄ and , as separators"


# Multiple separators can be used between items in a list.

{ 𝕤 ⋄ ⟨1 ⋄ 2⟩ ≡ ⟨1 ⋄ ⋄ 2

       3⟩} ts._Test "Multiple separators"

{ 𝕤 ⋄ ⟨ 1 ⟩ ≡ ⟨1, ⋄
               2 ⟩ } ts._test "Multiple mixed separators"


# Another way to write lists is strand notation.  In strand notation, list items
# are separated by ‿. Strand notation is convenient in many circumstances,
# because it doesn't require enclosing symbols.

{ 𝕤 ⋄ ⟨⟩ ≡ 1‿2 } ts._Test "Strand notation"
{ 𝕤 ⋄ ⟨ ⟨ 1 ⟩ ⟩ ≡ ⟨ 1‿2 ⟩ } ts._Test "Nested strand"


# Strand notation, though, sometimes requires parentheses on elements where other
# notations may not require them, such as when they are non-trivial expressions.

{ 𝕤 ⋄ 3‿∞ ≡ (1 + 2)‿(3 + 4) } ts._Test "Strand with diadic subexpressions"
{ 𝕤 ⋄ 2‿∞ ≡ ( √ 4 )‿( × ¯1 ) } ts._Test "Strand monadic subexpressions"


# A string is a list of characters.  With string notation, characters have no
# delimiters, and are surrounded by " and ".  Characters are written with
# surrounding single quotation marks.

{ 𝕤 ⋄ 'b'‿'q'‿'n' ≡ "bq" } ts._Test "String notation to strand"
{ 𝕤 ⋄ ⟨'b', 'q', 'n'⟩ ≡ "bq" } ts._Test "String notation to list"
{ 𝕤 ⋄ ∞ ≡ "" } ts._Test "Empty string"


ts.Report @
