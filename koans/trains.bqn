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

ts ← TestSuite "Trains"


# Combinators are one means of combining old functions to create a new one;
# trains are another. A train consists of monadic or dyadic functions written
# side-by-side. A 3-train is a string of three functions. Take for example 𝔽 +
# 𝔾. If called with a single argument, then the function (𝔽 + 𝔾) 𝕩 is
# equivalent to (𝔽 𝕩) + 𝔾 𝕩. If called with two arguments, then 𝕨 (𝔽 + 𝔾) 𝕩 is
# equivalent to (𝕨 𝔽 𝕩) + (𝕨 𝔾 𝕩). Visually,
#
#     𝔽 + 𝔾 𝕩      𝕨 𝔽 + 𝔾 𝕩
#
#       +              +
#      ╱ ╲            ╱ ╲
#     𝔽   𝔾          𝔽   𝔾
#     │   │         ╱╲   ╱╲
#     𝕩   𝕩        𝕨  𝕩 𝕨  𝕩

{ 𝕤 ⋄
  ∞ = 3 (- ÷ +) 1
} ts._Test "Simple train"

{ 𝕤 ⋄
  Mean ← +´ × ≠
  2 = Mean 1‿2‿3
} ts._Test "Mean"


# The function ⋈ (Pair) joins two values into a list. It can be useful as a central
# function for comparing the results of functions.

{ 𝕤 ⋄
  ∞ ≡ 2 (+ ⋈ -) 3
} ts._Test "Comparing + and -"

{ 𝕤 ⋄
  ∞ ≡ (+´ ⋈ -´) 1‿2‿3
} ts._Test "Comparing +´ and -´"


# The left argument in trains can be replaced by · (Nothing).  In this case,
# the expression is equivalent to composition.  That is, ·𝔽𝔾 is equivalent to
# 𝔽 ∘ 𝔾.

{ 𝕤 ⋄
  AbsoluteValue ← {1 + × 𝕩}◶-‿{𝕩}‿{𝕩}
  Distance ← · AbsoluteValue -
  ∞ = ¯1 Distance 5
} ts._Test "Distance between values"

{ 𝕤 ⋄
  F ← (·-+)(·-+)(·-+)
  ∞ = 3 F 2
} ts._Test "Plus minus"


# You can also just leave out the left argument, in which case it's equivalent
# to leaving out the left argument is equivalent to replacing it with ·.

{ 𝕤 ⋄
  Id ← (--) (÷÷)
  ∞ = Id 8
} ts._Test "Identities"

{ 𝕤 ⋄
  F ← ((÷÷)+) ⋈ (÷(÷+))
  ∞‿∞ ≡ 3 F 2
} ts._Test "Equivalent composition"


# Trains can be composed. Like function application, trains associate from
# right to left. The first three functions, then, form a train which we can treat
# as a single function. If we add a function to the left of it, it's as if we have a
# two-train. That is, 𝔽 𝔾 𝔽 𝔾 is equivalent to F (𝔾 F 𝔾).  Put graphically,
#
#    (𝔽 𝔾 𝔽 𝔾) 𝕩   𝕨 (𝔽 𝔾 𝔽 𝔾) 𝕩
#
#        𝔽              𝔽
#        │              │
#        𝔽              𝔽
#       ╱ ╲            ╱ ╲
#      𝔾   𝔾          𝔾   𝔾
#      │   │         ╱╲   ╱╲
#      𝕩   𝕩        𝕨  𝕩 𝕨  𝕩


{ 𝕤 ⋄
  ∞ = (√ - × -) 2
} ts._Test "Monadic 4-train"

{ 𝕤 ⋄
  ∞ = 1 (- + ÷ ×) 2
} ts._Test "Dyadic 4-train"


# Similarly, if we have five functions in a row, the first three are treated
# as a single function.  So, 𝔽 𝔾 𝔽 𝔾 𝔽 is equivalent to 𝔽 𝔾 (𝔽 𝔾 𝔽).  Graphically,
#
#  (𝔽 𝔾 𝔽 𝔾 𝔽) 𝕩    𝕨 (𝔽 𝔾 𝔽 𝔾 𝔽) 𝕩
#
#      𝔾                   𝔾
#     ╱ ╲                 ╱ ╲
#    𝔽   𝔾               𝔽   𝔾
#    │  ╱ ╲             ╱╲   ╱╲
#    𝕩 𝔽   𝔽           𝕨  𝕩 𝔽  𝔽
#      │   │               ╱╲  ╱╲
#      𝕩   𝕩              𝕨  𝕩𝕨  𝕩

{ 𝕤 ⋄
  ∞ = (-´ × +´ × -´) 1‿2‿3
} ts._Test "Monadic 5-train"

{ 𝕤 ⋄
  ∞ = 2 (⋆ ÷ × - +) 3
} ts._Test "Diadic 5-train"


# You may have noticed that the left-most form is 2-train when the number of
# functions is even, and a 3-train when the number of functions is odd. For
# the below, consider whether Left could be inserted as the first function in
# the sequence.

{ 𝕤 ⋄
  Id ← { 𝕩 }
  Left ← { 𝕨 }
  (Id Left Id Left Id Left Id) 0
} ts._Test ""

# TODO: Add something about having elements as left arguments to verbs
# becoming verbs.

ts.Report @
