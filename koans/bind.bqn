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

ts ← TestSuite "Under"


# Two combinators which are particularly useful with ⌾ are ⊸ (Before) and ⟜
# (After). These combinators have several purposes, all related to applying a
# function to one argument before passing to another function. 𝔽⊸𝔾 𝕩 is
# equivalent to (𝔽 𝕩) 𝔾 𝕩, and 𝕨 𝔽⊸𝔾 𝕩 is equivalent to (𝔽 𝕨) 𝔾 𝕩. Similarly,
# 𝔽⟜𝔾 𝕩 is equivalent to 𝕩 𝔽 (𝔾 𝕩) and 𝕨 𝔽⟜𝔾 𝕩 is equivalent to 𝕨 𝔽 (𝔾 𝕩).
# Graphically,
#
#       𝔽⊸𝔾 𝕩    𝕨 𝔽⊸𝔾 𝕩    𝔽⟜𝔾 𝕩    𝕨 𝔽⟜𝔾 𝕩
#
#        𝔾          𝔾        𝔽          𝔽
#       ╱ ╲        ╱ ╲      ╱ ╲        ╱ ╲
#      𝔽   𝕩      𝔽   𝕩    𝕩   𝔾      𝕨   𝔾
#      │          │            │          │
#      𝕩          𝕨            𝕩          𝕩
#
# In short, ⊸ and ⟜ apply a function to the left or right argument, respectively,
# before passing it to a function.  Remember that the function which is applied
# first is at the pointy end of the combinator.

{ 𝕤 ⋄
  ∞ = 2 ÷⊸× 6
} ts._Test "Preprocessing left side"

{ 𝕤 ⋄
  ∞ = 2⊸⊑ 2‿7‿1‿8‿2
} ts._Test "With value to bind argument"


# If only one argument is given to a verb modified with ⊸ or ⟜, then that
# argument is applied to both sides of the verb.

{ 𝕤 ⋄
  3‿3 ≡ -⊸⋈ 3
} ts._Test "Comparing negation"

{ 𝕤 ⋄
  9‿9 ≡ ⋈⟜√ 9
} ts._Test "Comparing square root"

{ 𝕤 ⋄
  2‿2 ≡ ×˜⊸⋈ 2
} ts._Test "Comparing square"


# We can use ⟜ in conjunction with ⊑ and ⌾ to build a modified array at a given
# index.

{ 𝕤 ⋄
  nums ← 1‿1‿2‿0‿5‿8‿13
  1‿1‿2‿0‿5‿8‿13 ≡ 3⌾(3⊸⊑) nums
} ts._Test "Update the fourth element"

{ 𝕤 ⋄
  ∞‿∞‿∞ ≡ 1⌾⊑ 2⌾(1⊸⊑) 3⌾(2⊸⊑) 0‿0‿0
} ts._Test "Multiple updates"

{ 𝕤 ⋄
  ∞ ≡ 0‿0⌾(¯1⊸⊏) 3‿2 ⥊ 1
} ts._Test "Update last element"


# Combinations of ⊸ and ⟜ can be somewhat complex, but some patterns are more
# useful than others. Take the combination F⊸G⟜H as an example. The normal
# order of application for verbs is from right to left. But modifiers are
# applied from left to right. So F⊸G⟜H is equivalent to (F⊸G)⟜H.  Graphically,
#
#     ((F⊸G)⟜H) 𝕩            𝕨 ((F⊸G)⟜H) 𝕩
#
#       (G⊸H)                    (G⊸H)
#        ╱ ╲                      ╱ ╲
#       𝔽   𝕩                    𝔽   𝕩
#       │                        │
#       𝕩                        𝕨
#
# Which, expanding G⟜H, is equivalent to
#
#      (F⊸G⟜H) 𝕩            𝕨 (F⊸G⟜H) 𝕩
#
#         G                      G
#        / \                    / \
#       F   H                  F   H
#      /     \                /     \
#     𝕩       𝕩              𝕨       𝕩
#
# F⊸G⟜H, then, is a way to preprocess arguments with different verbs.  In that
# way, it's similar to dyadic ○: 𝕨 (F○G) 𝕩 could be rewritten 𝕨 (G⊸F⟜G) 𝕩.

{ 𝕤 ⋄
  Square ← ⋆⟜2
  DiffOfSquare1 ← -○Square
  DiffOfSquare2 ← ∞˙
  3 (DiffOfSquare1 = DiffOfSquare2) 2
} ts._Test "Bind-over equivalence"


# Another useful pattern is F⟜G⟜H.  Since modifiers are applied left to right,
# it's equivalent to (F⟜G)⟜H.  Effectively, this preprocesses the left argument
# twice.

{ 𝕤 ⋄
  Square ← ⋆⟜2
  ∞ = 3 (-⟜√⟜Square) ¯2
} ts._Test "Preprocessing the right"


# However, F⊸G⊸H isn't quite the same.  The following are equivalent versions of
# the dyad:
#
#     𝕨 F⊸G⊸H 𝕩
#     𝕨 (F⊸G)⊸H 𝕩                 By modifier application
#     ((F⊸G) 𝕨) H 𝕩               By definition of ⊸
#     ((F 𝕨) G 𝕨) H 𝕩             By definition of ⊸
#
# Which is a good deal more complex.

{ 𝕤 ⋄
  ∞ ≡ 3 -⊸×⊸÷ 9
} ts._Test ""


ts.Report @
