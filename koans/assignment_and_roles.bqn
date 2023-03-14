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

ts ← TestSuite "Assignment"


# Typing the same values over and over again can be tiring.  To make things
# easier, we can store values in variables using ←.  Before we can use ←, we
# should know something about types and roles.   A type describes a category of
# values.  The fundamental types in BQN are numbers, characters, arrays,
# functions, 1-modifiers, 2-modifiers, and namespaces.  The role of the value
# describes how that value will be used.  When we store a value using ←, the
# name we use should reflect the role.  When a value is used as a subject role,
# the first letter should be lowercase, and should not start with a '_'. The
# number, character, and array types have the subject role by default.

{ 𝕤 ⋄
  p ← 1‿2‿3
  ∞ = +´ p
} ts._Test "Simple variable substitution"

{ 𝕤 ⋄
  a ← 1‿2‿3‿4
  b ← 2
  ∞ = +´ b × a
} ts._Test "Multiple variables"

{ 𝕤 ⋄
  shape ← ↑‿2
  data ← 1‿2‿3‿4‿5‿6‿7
  ∞ ≡ +˝ shape ⥊ data
} ts._Test "Add odd and even numbers"


# If a value is going to be used as a function (the function role), its name
# should begin with a capital letter, and should not start or with a '_'.
# Variable names are case insensitive, which is used in BQN to mix roles.  For
# example, we may want to use the number 2 as a function, which is equivalent to
# 2˙ (a constant function.)
#
# The role of a variable is a syntactic property which is enforced by the
# interpreter.  To see how this works in practice, change the lowercase 'm' below
# to an uppercase 'M' and run the script to see the error message produced. Then
# change the uppercase 'M' to a lowercase letter.  In each case, you can see that
# the interpreter recognizes how a value is being used, and enforces the spelling
# convention for that particular role.

{ 𝕤 ⋄ m ← 3 ⋄ M 5 }

{ 𝕤 ⋄
  a ← 2
  ∞ = A 3
} ts._Test "Number value with function role"

{ 𝕤 ⋄
  caseInsensitive ← "insensitive"
  ∞ ≡ Caseinsensitive 3
} ts._Test "Array value with function role"


# Since functions are values, we can also assign them to variables.  They have
# the function role by default. At the moment, it is not particularly useful, as
# we the only way we have created new functions is by apply modifiers to the
# built-in functions.  Soon, though, we'll see how to define functions more
# generally.

{ 𝕤 ⋄
  Frobinate ← ÷
  ∞ = 4 Frobinate 2
} ts._Test "Function with a function role"

{
  Deshape ← ⥊
  ∞ ≡ Deshape ↑‿4 ⥊ 1‿2‿3
} ts._Test "Deshaping"

{ 𝕤 ⋄
  SumOver ← +´
  ∞ = SumOver 1‿2‿3
} ts._Test "Using function names as documentation"

{ 𝕤 ⋄
  DivideOverRows ← ÷´˘
  ∞ ≡ ↑‿2 ⥊ 10‿5‿4‿2
} ts._Test "Divide over each row"


# One-modifier values have a 1-modifier role by default.  This role follows
# the convention of begining with an '_'. (But it should not end with a '_'.)

{ 𝕤 ⋄
  _Each ← ¨
  ∞ ≡ 0˙ _Each 1‿2‿3
} ts._Test "Each with 1-modifier role"

{ 𝕤 ⋄
  _Fold ← ´
  ∞ ≡ × _Fold 1‿2‿3
} ts._Test "Fold with 1-modifier role"

{ 𝕤 ⋄
  _Insert ← ˝
  ∞ ≡ ÷ _Insert 2‿3 ⥊ 15‿10‿5‿3‿2‿1
} ts._Test "Insert with 1-modifier role"


# Two-modifier values have a 2-modifier role by default. We haven't yet seen a
# 2-modifier. They're similar to 1-modifiers—which take a value and return a
# function—but 2-modifiers take two values (a left and right argument), and
# return a function.
#
# ∘ (Atop) is a 2-modifier which is modeled after mathematical composition.
# The function 𝔽 ∘ 𝔾 is a function which first applies 𝔾 to its arguments,
# then applies 𝔽 to the results of those arguments.  That is, 𝔽 ∘ 𝔾 𝕩 is equivalent
# to 𝔽 (𝔾 x), and 𝕨 𝔽 ∘ 𝔾 𝕩 is equivalent to 𝔽 (𝕨 𝔾 𝕩).  Graphically, it can
# be depicted
#
#     𝔽 ∘ 𝔾 𝕩      𝕨 𝔽 ∘ 𝔾 𝕩
#
#       𝔽              𝔽
#       │              │
#       𝔾              𝔾
#       │             ╱ ╲
#       𝕩            𝕨   𝕩
#
# First, we'll see how to use ∘, then we'll assign it to a variable to see how
# that role is communciated.

{ 𝕤 ⋄
  ∞ = ÷ ∘ √ 4
} ts._Test "Using a 1-modifier"

{ 𝕤 ⋄
  ReciprocalSum ← ÷ ∘ (+´)
  ⟨0.5, ∞, ∞⟩ ≡ ReciprocalSum¨ ⟨
    1‿1
    1‿1‿2
    1‿2‿3‿4
  ⟩
} ts._Test "ReciprocalSum"

{ 𝕤 ⋄
  Tens ← 10˙ × ⊏
  ∞ = +´ Tens 1‿3 ⥊ 1‿2‿3
} ts._Test "Ten times the first major cell"


# The spelling convention for a 2-modifier is for it to begin and end with a '_'.

{ 𝕤 ⋄
  _Atop_ ← ∘
  ∞ = √ _Atop_ - ¯9
} ts._Test "2-modifier with 2-modifier role"


ts.Report @
