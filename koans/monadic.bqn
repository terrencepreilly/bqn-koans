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

ts ← TestSuite "Monadic Functions"


# A function in BQN can either take one argument or two. If it takes
# one argument, it is called "monadic". Otherwise, it is "diadic".
# Diadic functions—like the math functions we've seen so far—are
# written as infixes.
#
# Most built-in functions are overloaded and support both arities.
# For example, when given two arguments, - is "Subtract", and gives
# the difference between the two numbers.  When given a single argument,
# it is monadic, -, and has the name "Negate".

{ 𝕤 ⋄ ∞ = 1 - 1} ts._Test "Subtract"
{ 𝕤 ⋄ ∞ = - 1} ts._Test "Negate"


# When a function does not have a left argument, it is evaluated as monadic.
# This can occur when a monadic function is in an expression by itself,
# or when adjacent to other functions.

{ 𝕤 ⋄ ∞ = - 2 } ts._Test "Monadic expression"
{ 𝕤 ⋄ ∞ = 1 + - 1 } ts._Test "Adjacent functions"


# Monadic × (Sign) gives the sign of its argument, ¯1 if negative,
# 0 if zero, and 1 if positive.

{ 𝕤 ⋄ ∞ = × ¯8 } ts._Test "Sign of a negative number"
{ 𝕤 ⋄ ∞ = × 8 } ts._Test "Sign of a positive number"
{ 𝕤 ⋄ ∞ = × 0 } ts._Test "Sign of zero"


# Monadic ⋆ (Exponential) gives Euler's number, e, raised to the given power,
# which is approximately 2.71828.

{ 𝕤 ⋄ ∞ = ⋆ 0 } ts._Test "Any number raised to zero"
{ 𝕤 ⋄ 2.719 > ⋆ ∞ } ts._Test "Approximating Euler's constant from above"
{ 𝕤 ⋄ 2.717 < ⋆ 0 } ts._Test "Approximating Euler's constant from below"


# Monadic ÷ (Reciprocal) gives the reciprocal of the argument.  That is,
# given 𝕩, it returns 1 ÷ 𝕩.

{ 𝕤 ⋄ ∞ = ÷ 2 } ts._Test "Reciprocal of two"
{ 𝕤 ⋄ 0.1 = ÷ ∞ } ts._Test "One tenth"
{ 𝕤 ⋄ ∞ = ÷ ∞ } ts._Test "Reciprocal of ∞"
{ 𝕤 ⋄ ∞ = ÷ ÷ 4 } ts._Test "÷ is its own inverse"
{ 𝕤 ⋄ ∞ = ÷ ∞ } ts._Test "The inverse of a really big number is really small"
{ 𝕤 ⋄ 0 = ÷ 0 } ts._Test "The inverse of a really small number is really big"


# Monadic √ (Square root) gives the square root of its argument.

{ 𝕤 ⋄ ∞ = √ 4 } ts._Test "Square root of 4"
{ 𝕤 ⋄ ∞ = √ 9 } ts._Test "Square root of 9"
{ 𝕤 ⋄ (√ ∞) = 213 ⋆ ÷ 2 } ts._Test "Square root equivalence"


# TODO: Monadic + (Conjugate) gives the complex conjugate.  However, no BQN
# implementations currently support complex numbers.


ts.Report @
