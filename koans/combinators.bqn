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

ts ← TestSuite "Combinators"


# We recently learned about using ∘ (Atop) for creating new functions.
# ∘ is known as a combinator, which is a type of higher-order function.
# ˙ (Constant) is another combinator.  Combinators can be used exclusively to create
# programs in what is called tacit programming, or point-free style.
# Instead of using if-statements, for-loops, and other control constructs,
# combinators can be used to build complex functionality.
# Because they don't specify arguments explicitly, combinators lend
# themselves to very concise programs.
#
# ˜ (Self) is another combinator.  When applied to a diadic function to
# which a single argument is supplied, it supplies that argument on
# both sides.  That is, 𝔽˜ 𝕩 is equivalent to 𝕩 𝔽 𝕩.

{ 𝕤 ⋄ ∞ = +˜ 2 } ts._Test "Add Self"
{ 𝕤 ⋄ ∞ = ×˜ 2 } ts._Test "Multiply Self"
{ 𝕤 ⋄ ∞ = ⋆˜ 2 } ts._Test "Power Self"
{ 𝕤 ⋄ ∞‿∞‿∞ ≡ +˜ 1‿2‿3 } ts._Test "Pervasive Self functions still pervasive"

{ 𝕤 ⋄ ∞‿∞‿∞ ≡ ÷˜ ¯8‿123‿7.532 } ts._Test "Divide Self"
{ 𝕤 ⋄ ∞‿∞‿∞ ≡ -˜ 52‿¯12‿0.3 } ts._Test "Subtract Self"

{ 𝕤 ⋄ ∞ = ×˜∘(+´) 1‿2‿3 } ts._Test "Self on left argument of Atop"

{ 𝕤 ⋄ ⟨3, 3, 3⟩‿⟨2, 2⟩‿⟨1⟩ ≡ ⥊ 3‿2‿1
} ts._Test "Self size"


# When applied to a function which will take two arguments,
# ˜ (Swap) swaps the arguments in question.  That is, 𝕨 𝔽˜ 𝕩 is equivalent
# to 𝕩 𝔽 𝕨.

{ 𝕤 ⋄ ∞ = 1 -˜ 2 } ts._Test "Subtract Swap"
{ 𝕤 ⋄ ∞ = 2 ÷˜ 32 } ts._Test "Divide Swap"
{ 𝕤 ⋄
  Dim ← 2‿∘˙
  ∞ ≡ 1 ⊏ 1‿2‿3‿4 ⥊˜ Dim 0
} ts._Test "Second half of numbers"

{ 𝕤 ⋄ 3 = 9 √ 2 } ts._Test "Root swap"

# This can be useful to reduce the number of parentheses needed, at times.
# The below examples are somewhat contrived, but the same principal will
# prove useful once we cover more tacit programming.
#
# Note: add parentheses to the right side to form an equivalent expression.


{ 𝕤 ⋄ (2 ÷˜ 9 - 3) = 9 - 3 ÷ 2} ts._Test "Reduce parentheses"
{ 𝕤 ⋄ (8‿27 √˜ 6 - 3) ≡ 6 - 3 √ 8‿27 } ts._Test "Reduce more parentheses"

{ 𝕤 ⋄
  a ← (1 + 2) √ 27
  # Note: rewrite the above expression without parentheses.
  a = ∞
} ts._Test "Rearrange to reduce parentheses"

# ○ (Over) is a combinator similar to ∘.  In the monadic case, they act
# the same.  That is, 𝔽 ○ 𝔾 𝕩 is equivalent to 𝔽 ∘ 𝔾 𝕩 which is equivalent
# to 𝔽 (𝔾 𝕩).  In the diadic case, ∘ passes both arguments to 𝔾, and then
# passes the result to 𝔽.  ○, though, passes each argument, separately, to
# a monadic 𝔾, then passes the results to a diadic 𝔽.  That is,
# 𝕨 𝔽 ○ 𝔾 𝕩 is equivalent to (𝔾 𝕨) 𝔽 (𝔾 𝕩).  Shown graphically,
#
#     𝔽 ○ 𝔾 𝕩      𝕨 𝔽 ○ 𝔾 𝕩
#
#       𝔽              𝔽
#       │             ╱ ╲
#       𝔾            𝔾   𝔾
#       │            │   │
#       𝕩            𝕨   𝕩
#
# You may notice that both ∘ and ○ are circles.  All 2-modifiers contain
# a circle in their symbols, similar to how all 1-modifiers are superscript.

{ 𝕤 ⋄ ∞ = 2 - ○ (×˜) 3 } ts._Test "Difference of squares"
{ 𝕤 ⋄ ∞ = -´ ○ (×˜) 2‿3 } ts._Test "Another difference of squares"

{ 𝕤 ⋄
  LongerThan ← >○≠
  ∞‿∞‿∞ ≡ ⟨
    "shape" LongerThan "rank"
    "dyadic" LongerThan "monadic"
    "apl" LongerThan "bqn"
  ⟩
} ts._Test "Comparing string length"

{
  # Note: The tables' contents should remain unchanged.
  table1 ← ↑‿2‿3 ⥊ 1‿2‿3‿4‿5‿6‿7‿8‿9
  table2 ← ↑‿1‿6 ⥊ 1‿2‿3‿4‿5‿6‿7‿8‿9
  table1 ≢○(⥊˘) table2
} ts._Test "Comparing table contents"

{ 𝕤 ⋄
  AbsoluteValue ← √∘×˜
  EquivalentMagnitude ← ≡ # Hint: update this function
  9‿2‿3 EquivalentMagnitude ¯9‿2‿¯3
} ts._Test "Checking magnitude"

{ 𝕤 ⋄
  array1 ← 1‿3 ⥊ 1‿2
  array2 ← 3‿1 ⥊ 1‿2
  ∞ ≡ array1 +○⥊ array2
} ts._Test "Adding dissimilar shaped arrays"

{ 𝕤 ⋄
  xs ← 0‿1
  ys ← 0‿3

  Slope ← ÷○(-´)˜
  ∞ ≡ xs Slope ys
} ts._Test "Slope of the line"


ts.Report @
