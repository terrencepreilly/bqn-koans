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

⟨TestSuite⟩ ← •Import "../test.bqn"

ts ← TestSuite "Reverse, Rotate, Transpose"

# We've several means of working with and transforming arrays so far: how to
# take elements from an array with ⊏, how to construct a new array using
# structural ⌾, how to reshape an array with ⥊ (even leaving one dimension
# empty with ∘ and filling extra spaces with ↑), how to reduce elements of an
# array using ´ and reduce cells using ˝, how to map a function to elements of
# an array using ¨ or to cells using ˘. There are yet other means of
# transforming arrays.
#
# ⌽ (Reverse) is a monadic verb which reverses a list.

{ 𝕤 ⋄
  ∞ ≡ ⌽ "esreveR"
} ts._Test "Reverse a list"

{ 𝕤 ⋄
   ⟨⟩‿⟨1⟩ ≡ ⌽ ⟨⟩‿⟨1⟩
} ts._Test "Reverse identity"

{ 𝕤 ⋄
  ∞ ≡ ⌽⁼ 1‿3‿5‿2
} ts._Test "Reverse inverse"

{ 𝕤 ⋄
  (2‿∘ ⥊ 1‿2‿3‿4) ≡ ⌽ (2‿∘ ⥊ 2‿1‿4‿3)
} ts._Test "Reverse cells"


# ⌽ (Rotate) is the dyadic version of ⌽.  It rotates a list cycically to the left.
# That is, n ⌽ x1‿x2‿...‿xk for some n < k will result in a list x(n+1)‿x(n+2)‿...‿x(n).

{ 𝕤 ⋄
  ∞ ≡ 1 ⌽ 1‿2‿3
} ts._Test "Move first element to end"

{ 𝕤 ⋄
  ∞ ≡ 2 ⌽ "recent"
} ts._Test "rotational anagram"


# An array has multiple axes, and ⌽ can operate on each of those axes independently.
# So, for example, if we have a rank 2 array, a ← 2‿2 ⥊ 0‿1‿2‿3,
#
#    ┌─
#    ╵ 0 1
#      2 3
#          ┘
#
# We can rotate across different axes by passing a list as the left argument of ⌽.
# The first element in the list rotates around the leading axis.  That is, it rotates
# the major cells of the array.  In that way, 1‿0 ⌽ a is equivalent to 1 ⌽ a.
# The second element in a list rotates the next axis. That is, it rotates the major
# cells of each of the major cells, so that 0‿1 ⌽ a is equivalent to 1 ⌽˘ a, and so on.
#
#   1‿0 ⌽ a      0‿1 ⌽ a
#
#   ┌─           ┌─
#   ╵ 2 3        ╵ 1 0
#     0 1          3 2
#         ┘            ┘
#
# Passing a list as the left argument allows us to rotate across different axes at the
# same time without having to use ˘.  Rather than 1 ⌽˘˘˘ 2 ⌽˘˘ 3 ⌽˘ 4 ⌽ a, we can write
# 4‿3‿2‿1 ⌽ a.
#
#   1‿1 ⌽ a      1‿2 ⌽ a
#
#   ┌─           ┌─
#   ╵ 3 2        ╵ 2 3
#     1 0          0 1
#         ┘            ┘

{ 𝕤 ⋄
  a ← 8‿3‿4 ⥊ 0‿1‿2‿3‿4‿4
  (1 ⌽ a) ≡ 5 ⌽˘˘ 2 ⌽˘ 3 ⌽ a
} ts._Test "Equivalence with cells"

{ 𝕤 ⋄
  a ← 3‿3 ⥊ 1‿2‿3‿4‿5‿6‿7‿8‿9
  ∞ ≡ +˝ (1‿1 ⌽ 3‿3 ⥊ 1‿0) × a
} ts._Test "Reshaping masks"


# ⍉ (Transpose) is another common array operation.  For a two-dimensional array
# whose elements are defined by a[i, j], where i is the row and j is the cell,
# ⍉ exchanges the i and j indices. (Visually, it flips the array along the diagonal
# from the top left to the bottom right.)

{ 𝕤 ⋄
  ∞ ≡ ⍉ 2‿2 ⥊ 0‿1‿2‿3
} ts._Test "Transpose"

{ 𝕤 ⋄
  ∞ ≡ ⍉ 2‿3 ⥊ 1‿2‿3‿4‿5‿6
} ts._Test "Transpose non-square array"


# An easy way to build arrays is the monadic verb, ↕ (Range).  Given a number, n,
# ↕ will return a list 0‿1‿...‿(n - 1).

{ 𝕤 ⋄
  0‿1‿2‿3 ≡ ↕ 3
} ts._Test "Simple range"

{ 𝕤 ⋄
  RangeEqual ← ≠∘↕ = ×
  ×´ RangeEqual¨ 1‿2‿3‿4‿5
} ts._Test "Length of range equals initial value"

{ 𝕤 ⋄
  # Make an 𝕩 by 𝕩 holding the values from 0 to 𝕩×𝕩.
  MakeArray ← ⋈˜ ⥊ ↕∘×˜

  (3‿3 ⥊ 1‿0‿0‿0‿1‿0‿0‿0‿1) ≡ (⊢ =¨ ⊢) MakeArray 3
} ts._Test "Building identity"

{ 𝕤 ⋄
  ∞ ≡ ⍉˘ 1‿2‿3 ⥊ ↕ 6
} ts._Test "Transposing cells"


# In order to transpose an array, ⍉ moves the first axis to the end.
# (This results in a typical transpose for rank-2 arrays.)

{ 𝕤 ⋄
  ∞ ≡ ≢ ⍉ 1‿2‿3 ⥊ ↕ 6
} ts._Test "Transpose's effect on shape"

{ 𝕤 ⋄
  ∞ ≡ ≢ ⍉⁼ ⍉ 1‿2‿3 ⥊ ↕ 6
} ts._Test "Undoing the transpose"

{ 𝕤 ⋄
  ∞ ≡ ≢ ⍉⁼ 1‿2‿3 ⥊ ↕ 6
} ts._Test "Transposing backwards"


# The dyadic verb, ⍉ (Reorder), reorders the axes by the left argument. The
# left argument describes where the axes of the array on the right will move.
# That is, a0‿a1‿...an ⍉ 𝕩 means that the first axis in 𝕩 will go to a0, the
# second axis will go to a1, ..., and the last axis will go to an.

{ 𝕤 ⋄
  ∞ ≡ ≢ 2‿0‿1 ⍉ 1‿2‿3 ⥊ ↕ 6
} ts._Test "Reordering axes"

{ 𝕤 ⋄
  ∞ ≡ ≢ 2‿1‿0 ⍉ 1‿2‿3 ⥊ ↕ 6
} ts._Test "Reversing axes"

{ 𝕤 ⋄
  2‿1‿3 ≡ ≢ 0‿0‿0 ⍉ 1‿2‿3 ⥊ ↕ 6
} ts._Test "Another rearranging"


ts.Report @
