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

ts ← TestSuite "Arrays"


# BQN is an array language, which means that the basic data structure of BQN is
# the array.  All values in BQN are either scalars or arrays. Examples of scalar
# values include numbers such as 1, or 3.1415, characters such as 'a' or '⍋'.
# Scalar values are single values and have no shape.  Arrays, on the other hand,
# have a shape.  The lists we have been dealing with so far are an example of an
# array.
#
# BQN displays arrays differently depending on the shape. An array of shape
# ⟨⟩ can be constructed using < (Enclose).  For example, < 0 is displayed
#
#    ┌·
#    · 0
#        ┘
#
# An array of shape ⟨ 4 ⟩ (a list), is displayed
#
#    ⟨ 0 1 2 3 ⟩
#
# An array of size ⟨ 2 2 ⟩ is displayed
#
#     ┌─
#     ╵ 0 1
#       2 3
#           ┘
#
# (Similar to the unit array, but with no dots.)  Arrays of higher order
# are displayed by separating by spaces.
#
#     ┌─
#     ╎ 0 1
#       2 3
#
#       4 5
#       6 7
#           ┘


# The shape of an array can be found using the monad ≢ (Shape).
# ≢ returns a list of numbers representing the size of each dimension
# of an array.  Since they have no shape, ≢ returns an empty list for
# scalars.  Each item in the returned array is an "axis" of the array.

{ 𝕤 ⋄ ∞ ≡ ≢ 1 } ts._Test "Shape of a number"
{ 𝕤 ⋄ ∞ ≡ ≢ ' ' } ts._Test "Shape of a character"


# Since a list has one dimension, its shape is equal to a list containing its
# length.

{ 𝕤 ⋄ ∞ ≡ ≢ 1‿2‿3 } ts._Test "Shape of a list"
{ 𝕤 ⋄ ∞ ≡ ≢ ⟨⟩  } ts._Test "Shape of an empty list"
{ 𝕤 ⋄ ∞ ≡ ≢ ⟨1‿2 ⋄ 3‿4⟩ } ts._Test "Shape of a nested list"


# To build arrays of higher dimensionality, we'll need some more functions.
# The diadic function, ⥊ (Reshape), takes an array of numbers (a shape) as
# a left argument, and an array on the right.  ⥊ reshapes the array to conform
# to the given shape.

{ 𝕤 ⋄ ∞ ≡ ≢ 2‿2 ⥊ 1‿2‿3‿4 } ts._Test "Checking a two-dimisional array's shape"
{ 𝕤 ⋄ ∞ ≡ ≢ 0 ⥊ 1‿2 } ts._Test "Checking a zero-dimensional array's shape"
{ 𝕤 ⋄ ∞ ≡ ≢ 1‿1‿1 ⥊ 1 } ts._Test "Three dimensional array"


# Sometimes you'll have an array of elements, and you want to reshape it,
# but you only know the value of one dimension.  For example, you may have
# a list of elements representing ranges, where odd numbers are the start
# of a range, and even numbers are the end of a range.  E.g.:
#
# 18‿20‿1‿3‿10‿11‿5‿8
#
# representing 18-20, 1-3, 10-11, 5-8.  You may want to reshape this into
# an array with two columns (say, so that you can sort it.)  You can do this
# by using the symbol ∘ for the unknown dimension in the shape.  For example,
# we could transform the above using
#
# ∘‿2 ⥊ 18‿20‿1‿3‿10‿11‿5‿8
#
# And we would get
#
#    ┌─
#    ╵ 18 20
#       1  3
#      10 11
#       5  8
#            ┘

{ 𝕤 ⋄ ∞ ≡ ≢ 1‿∘ ⥊ 1‿2‿3‿4‿5‿6 } ts._Test "Reshaping to a single row"
{ 𝕤 ⋄ ∞ ≡ ≢ ∘‿3 ⥊ 1‿2‿3‿4‿5‿6 } ts._Test "Reshaping to a three-column table"


# If an array is too small for the shape it's given, ⥊ will reuse
# the elements of the array, cyclically.

{ 𝕤 ⋄ ∞ ≡ ⟨4⟩ ⥊ 1‿2‿3 } ts._Test "Recycling numbers"
{ 𝕤 ⋄ ∞ ≡ ⟨4⟩ ⥊ "abc" } ts._Test "Recycling characters"
{ 𝕤 ⋄ ∞ ≡ ⟨6⟩ ⥊ 1‿2‿3 } ts._Test "Recycling an entire list"
{ 𝕤 ⋄ ∞ ≡ ⟨8⟩ ⥊ 1‿2‿3 } ts._Test "Reusing elements multiple times"
{ 𝕤 ⋄ ∞ ≡ ⟨3⟩ ⥊ 0 } ts._Test "Reshaping a single number"
{ 𝕤 ⋄ ∞ ≡ ⟨2⟩ ⥊ 2‿2‿2‿2 ⥊ 1‿3 ⥊ 6‿2 ⥊ "abc" } ts._Test "Preservation of initial values"
{ 𝕤 ⋄ ∞ ≡ ⟨2⟩ ⥊ 2‿2‿2‿2 ⥊ ⟨1⟩ ⥊ 6‿2 ⥊ "abc" } ts._Test "Non-preservation of initial values"


# The monadic version of ⥊ (Deshape) creates a list containing all
# of the elements of the array.

{ 𝕤 ⋄ ∞ ≡ ⥊ 2‿3 ⥊ "abcdef" } ts._Test "Shaping and deshaping"
{ 𝕤 ⋄ ∞ = ≠ ⥊ 3‿9 ⥊ 0 } ts._Test "Getting number of elements from the shape"


# Besides a shape and elements, arrays have other properties.  An array's "fill
# element" is like a default element of an array.  It is used to fill in a result
# when there are insufficient elements in the original array. For example, ⥊
# will use the fill element of the array if the shape contains ↑.  Similar to
# ∘, ↑ replaces a dimension in the shape.  The fill element of the array
# attempts to satisfy some property of the existing elements in the array.  If
# the elements are all numbers, the fill should be 0.  If the elements are all
# characters, the fill should be ' '. For details of how the fill element is
# calculated, see https://mlochbaum.github.io/BQN/doc/fill.html.

{ 𝕤 ⋄ ∞ ≡ ⥊ 2‿↑ ⥊ 1‿2‿3 } ts._Test "Filling an array of numbers"
{ 𝕤 ⋄ ∞ ≡ ⥊ 2‿↑ ⥊ "abc" } ts._Test "Filling an array of characters"


# So far, when discussing the values that make up an array, we've been discussing
# elements.  Elements are the smallest component values of an array: values like
# 1 or 'z'.  An array with no elements is empty.  The 1-modifier, ¨, applies the
# function to every element in the array.

{ 𝕤 ⋄ ∞ = ≠ ⥊ 2‿3‿2 ⥊ 1‿2‿3 } ts._Test "Get # of elements in the array"

# HINT: Add a 1-modifier to finish the expressions
{ 𝕤 ⋄ (3‿1 ⥊ 1) ≡ 1˙ 3‿↑ ⥊ 1‿2 } ts._Test "Modifying elements in the array"
{ 𝕤 ⋄ 9 ≡ × ≢ 3‿1‿3 ⥊ 'a' } ts._Test "Another way to get # of elements"


# Cells are another way of describing the contents of an array. Cells are
# subarrays of the array.  The major cells of an array are the subarrays
# at each index along the first axis of an array.  The major cell of an
# array has one fewer axis than the original array.  For example, if we have
# an array, 2‿2 ⥊ "abcd", which looks like
#
#    ┌─
#    ╵"ab
#      cd"
#         ┘
#
# Then the first major cell of 2‿2 ⥊ "abcd" has the shape ⟨2⟩, which is
# the list: "ab".

# To extract the major cell of an array, we can use the function ⊏ (Select).  ⊏
# takes an index on the left, and the array on the right.

{ 𝕤 ⋄ ∞ ≡ 0 ⊏ 2‿2 ⥊ "abcd" } ts._Test "Get first major cell"
{ 𝕤 ⋄ ∞ ≡ 1 ⊏ 2‿2 ⥊ "abcd" } ts._Test "Get second major cell"


# The 1-modifier ´, which we saw earlier, inserts the given function between
# the elements of its argument.  Similarly, ˝ (Insert) inserts the given function
# between the major cells of its argument.

{ 𝕤 ⋄ ∞ ≡ +˝ 2‿2 ⥊ 1‿2‿3‿4 } ts._Test "Summing columns"
{ 𝕤 ⋄
  (+´ ⟨3⟩ ⥊ ⟨1⟩) ≡ +˝ 3‿3 ⥊ 1‿2‿3
} ts._Test "Adding lists vs summing columns"

{ 𝕤 ⋄ ∞ = +´ ⟨3⟩ ⥊ 1 } ts._Test "Summing over a list"
{ 𝕤 ⋄ ∞ = +´ +˝ 3‿3 ⥊ 1 } ts._Test "Summing over summed columns"
{ 𝕤 ⋄
  ∞ = +´ +˝ +˝ 3‿3‿3 ⥊ 1
} ts._Test "Sum over summed columns of summed tables"


# The 1-modifier ¨ applies the function to the elements of the array.
# Likewise, the 1-modifier ˘ (Cells) applies the function to the major cells
# of the array.

{ 𝕤 ⋄ ∞ ≡ ≠˘ 2‿3 ⥊ 1 } ts._Test "Length of major cells"

{ 𝕤 ⋄
  ∞ ≡ +´˘ 2‿3 ⥊ 1‿1‿1‿2‿2‿2
} ts._Test "Sum the rows of an array"

{ 𝕤 ⋄
  (2‿2 ⥊ ⟨1⟩) ≡ ⊏˘ 2‿2‿2 ⥊ 1‿2‿3‿4
} ts._Test "Take the first major cell of each major cell"


ts.Report @
