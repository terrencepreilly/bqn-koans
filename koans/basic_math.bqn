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

ts ← TestSuite "Basic Maths"

# BQN Koans
#
# To complete the koans, make the last statement in each test function
# true.  For example, the following test demonstrates the use of the
# function + (Add).  Replace the ∞ with the number 2.

{ 𝕤 ⋄ ∞ = 1 + 1 } ts._Test "Addition"
{ 𝕤 ⋄ ∞ = 1 + 0 } ts._Test "Addition identity"


# Subtraction is done with - (Subtract).  In these koans,
# function will be denoted primarily with their glyphs, with their names
# appearing in parentheses.

{ 𝕤 ⋄ ∞ = 2 - 1 } ts._Test "Subtraction"
{ 𝕤 ⋄ ∞ = 2 - 0 } ts._Test "Subtraction identity"
{ 𝕤 ⋄ ∞ = 1 - 1 } ts._Test "Subtract a number from itself"


# Negative numbers are denoted with ¯.

{ 𝕤 ⋄ ∞ = 2 + ¯1 } ts._Test "Negative addition"
{ 𝕤 ⋄ ∞ = 1 - 2 } ts._Test "Negative result of subtraction"


# At times, koans will have an expresson on the left.  In this case,
# replace the ∞ to make final expression true.

{ 𝕤 ⋄ (1 + ∞) = 0 } ts._Test "Adding negative numbers"
{ 𝕤 ⋄ (∞ - 1) = ¯5 } ts._Test "Subtracting from a negative number"


# Multiplication is performed with × (Multiply).

{ 𝕤 ⋄ ∞ = 3 × 2 } ts._Test "Multiply"
{ 𝕤 ⋄ ∞ = 1 × ¯9 } ts._Test "Multiplication identity"
{ 𝕤 ⋄ (2 × ∞) = 4 } ts._Test "Doubling"

# And division is performed with ÷ (Divide).

{ 𝕤 ⋄ ∞ = 4 ÷ 2 } ts._Test "Divide"
{ 𝕤 ⋄ ∞ = 4 ÷ 1 } ts._Test "Division identity"

# ⋆ (Power) performs exponentiation.  The symbol is a unicode star,
# not the asterisk symbol.

{ 𝕤 ⋄ ∞ = 2 ⋆ 2 } ts._Test "Squared"
{ 𝕤 ⋄ ∞ = 2 ⋆ 3 } ts._Test "Cubed"
{ 𝕤 ⋄ ∞ = 2 ⋆ 4 } ts._Test "Fourth power"
{ 𝕤 ⋄ (3 ⋆ ∞) = 27 } ts._Test "Three raised to a power"
{ 𝕤 ⋄ (4 ⋆ ∞) = 4 × 4 × 4 × 4 × 4 × 4 } ts._Test "Four raised to a power"

# √ (Root) takes the root of a number.  That is, 𝕨 √ 𝕩 is equivalent to
# 𝕨 ⋆ 1 ÷ 𝕩.

{ 𝕤 ⋄ ∞ = 2 √ 16 } ts._Test "Square root"
{ 𝕤 ⋄ ∞ = 3 √ 8 } ts._Test "Cubed root"
{ 𝕤 ⋄ (∞ √ 614656) = 614656 ⋆ 1 ÷ 4 } ts._Test "Root equivalence to power"

ts.Report @
