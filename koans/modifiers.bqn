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

ts ← TestSuite "Modifiers"


# The functions we've seen so far take a value and return a value. BQN also
# supports higher-order functions, which return a function. One of the simplest
# of these is ˙ (Constant), which takes a value and returns a function whose
# result is always that value.

{ 𝕤 ⋄ ∞ = 0˙ "any value" } ts._Test "Numeric constant"
{ 𝕤 ⋄ ∞ ≡ "No"˙ ∞ } ts._Test "String constant"
{ 𝕤 ⋄ ∞ ≡ ⟨⟩˙ ∞ } ts._Test "List constant"
{ 𝕤 ⋄ ∞ = ' '˙ 1‿2‿3‿4 } ts._Test "Application to a list."


# Another simple modifier is ¨ (Each).  ¨ takes a function and returns a
# function which applies to each element in an array.  So, for example,
#
#    (𝕗¨ 𝕩1‿𝕩2‿...‿𝕩n) ≡ (𝕗 𝕩1)‿(𝕗 𝕩2)‿...‿(𝕗 𝕩n)
#
# You may have noticed that both modifiers are superscript symbols.  All built-in
# modifiers are symbols above superscripts, which makes them easy to distinguish
# from other types of functions.

{ 𝕤 ⋄ 2‿∞‿∞ ≡ ≠¨ ⟨1‿2, 1‿2‿3, 1‿2‿3‿4⟩ } ts._Test "Get lengths"
{ 𝕤 ⋄ 1‿∞ ≡ ≠¨ ⟨1⟩‿⟨1, 2⟩ } ts._Test "Applying length to each"
{ 𝕤 ⋄ 2‿∞ ≡ ≠¨ ⟨⟨1⟩, ⟨1, 2⟩⟩‿⟨1⟩ } ts._Test "Applying length again"


# We said previously that normal functions are evaluated from
# right to left.  We could represent this as a tree, so that
# 𝔽1 𝔽2 𝔽3 𝕩 could be represented
#
#    𝔽1
#      \
#       𝔽2
#        \
#         𝔽3
#           \
#            𝕩
#
# 𝔽3 must be evaluated before 𝔽2, in order to pass a value for 𝔽2's right
# argument. This is # right-associativity.  Equivalently, representing order
# with parentheses, we could say that the expression 𝔽1 𝔽2 𝔽3 𝕩 is
# equivalent to 𝔽1 (𝔽2 (𝔽3 𝕩)).
#
# Modifiers, however, associate to the left.  If _𝔽1, _𝔽2, & 𝔽3. are modifiers,
# and 𝔾 is a function, then we could represent 𝔾 _𝔽1 _𝔽2 𝔽3 as
# ((𝔾 _𝔽1) _𝔽2) _𝔽3.  Or, as a tree,
#
#         _𝔽3
#        /
#       _𝔽2
#      /
#     _𝔽1
#    /
#   𝔾

{ 𝕤 ⋄ ∞ ≡ 1˙¨ 2‿4 } ts._Test "Combining modifiers"


# Take another example, with ¨.  ¨ can be repeated to reach deeper into lists.
# Essentially, ≠¨¨ is equivalent to (≠¨)¨.  That is, ≠¨¨ applies ≠¨ to each of
# the elements of the list.

{ 𝕤 ⋄ ∞ = ≠ ⟨⟩ } ts._Test "Normal list length"
{ 𝕤 ⋄ ∞ ≡ ≠¨ ⟨⟨⟩, ⟨1⟩⟩} ts._Test "Length at depth 1"
{ 𝕤 ⋄ ∞ ≡ ≠¨¨ ⟨⟨⟨⟩, ⟨1⟩⟩, ⟨⟨1⟩, ⟨⟩⟩⟩} ts._Test "Length at depth 2"
{ 𝕤 ⋄ ∞ ≡ ≠¨¨¨ ⟨⟨⟨⟨⟩, ⟨1⟩⟩, ⟨⟨1⟩, ⟨⟩⟩⟩, ⟨⟨⟨⟩⟩⟩⟩ } ts._Test "Length at depth 3"


# Another useful modifier is ´ (Fold). ´ applies its argument between the
# elements of a list.  That is, 𝔽´ 𝕩1‿𝕩2‿𝕩3‿...‿𝕩n is equivalent to
# 𝕩1 𝔽 𝕩2 𝔽 𝕩3 𝔽 ... 𝔽 𝕩n.

{ 𝕤 ⋄ ∞ = =´ 0‿0‿1‿0‿1 } ts._Test "Check if all elements are equal"
{ 𝕤 ⋄ ∞ = ÷´ 4‿4‿4‿4‿4‿4‿2 } ts._Test "Repeated division"


# ´ generalizes a common pattern in many Mathematical expressions, called
# iterated binary operations. Typically these are written as large Greek letters,
# or large versions of the operations.  Summing over a list, for example, is
# written with a large ∑, and or'ing over a list of booleans is written with a
# large or-symbol, ∨.
#
# One major advantage of ´ is that it allows you to fold any binary function,
# whereas the Mathematical operations are special cases.

{ 𝕤 ⋄ ∞ = +´ 1‿2‿3‿4‿5 } ts._Test "Summing a list"
{ 𝕤 ⋄ ∞ = ×´ 1‿2‿3‿4‿5 } ts._Test "Multiplying over a list"
{ 𝕤 ⋄ ∞ = -´ 1‿2‿3‿4‿5 } ts._Test "Alternating series"


ts.Report @
