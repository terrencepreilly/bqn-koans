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


# Similar to mathematics, in BQN some functions can be inverted. ⁼ (Undo) is a
# 1-combinator which inverts a verb. That is 𝕩' = 𝔽 𝕩 is equivalent to 𝕩 = 𝔽⁼ 𝕩'.
# Likewise, 𝕩' = 𝕨 𝔽 𝕩 is equivalent to 𝕩 = 𝕨 𝔽⁼ 𝕩'

{ 𝕤 ⋄
  ∞‿8 ≡ 5 (+⁼ ⋈ +) 3
} ts._Test "Undoing addition"

{ 𝕤 ⋄
  ∞‿16 ≡ 2 (⋆⁼ ⋈ ⋆) 4
} ts._Test "Undoing power"

{ 𝕤 ⋄
  nums ← 3‿2‿¯3
  ∞ ≡ -⁼ - nums
} ts._Test "Invertible"


# Some functions, like ⋆, do not have a unique inverse.  For example,
# 2 ⋆ 2 = ¯2 ⋆ 2.  Should 2 ⋆˜⁼ 4 evaluate to 2 or ¯2?  BQN will pick
# one of the values.  In this case, the positive value.  This will only
# work for relatively simple cases.  ⁼ can't guess, for example, how to
# reshape an array, or other structural changes.

{ 𝕤 ⋄
  ∞ = 2 ⋆˜⁼ 4
} ts._Test "Non-unique power inverse"

{ 𝕤 ⋄
  ∞ = ×˜⁼ 9
} ts._Test "Square inverse"


# ⌾ (Under) is a 2-combinator similar to ⁼.  𝔽 ⌾ 𝔾 is equivalent to
# 𝔾⁼ ∘ 𝔽 ○ 𝔾.
#
#     𝔽⌾𝔾 𝕩    𝕨 𝔽⌾𝔾 𝕩
#
#      𝔾⁼         𝔾⁼
#      │          │
#      𝔽          𝔽
#      │         ╱ ╲
#      𝔾        𝔾   𝔾
#      │        │   │
#      𝕩        𝕨   𝕩

{ 𝕤 ⋄
  ∞ = 3 +⌾(×˜) 4
} ts._Test "Sum under square"

{ 𝕤 ⋄
  ¯81 = (×˜ ⌾ ×) ¯9
} ts._Test "Negative square"

{ 𝕤 ⋄
  1 = ¯1 (×˜)○⊢ ¯2
} ts._Test "Devolving to monadic"


# We said that ⁼ could not invert certain structural functions like reshaping,
# dropping or taking elements from an array. ⌾, on the other hand, can do so
# because it knows the original elements of the array. This is called
# "Structural Under".
#
# Take ⊑ as an example, which gets the first element of the array. If we would
# like to change the first element of the array to, say, 9, we could do
# something like 9⌾⊑. In this verb, the first element will be got from the
# array, the function 9 will be applied to it (which will always return 9),
# and then the transformed value will be placed back into the array at the
# same location.

{ 𝕤 ⋄
  ∞ ≡ 9⌾⊑ 3‿1‿1
} ts._Test "Replacing the first element"

{
  ∞ ≡ (0‿0)⌾⊏ 2‿2 ⥊ 1
} ts._Test "Replacing the first cell"


ts.Report @
