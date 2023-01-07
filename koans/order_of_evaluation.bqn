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

ts ← TestSuite "Order of Evaluation"


# Functions are evaluated from right to left. So, in the expression
# 2 × 3 - 1, the subexpression 3 - 1 is evaluated first. The result, 2, is then passed
# as the right argument of Multiply: 2 × 2.

{ 𝕤 ⋄ ∞ = 2 × 3 - 1 } ts._Test "Right to left"
{ 𝕤 ⋄ ∞ = 1 + 3 × 3 + 1 } ts._Test "Right to left 2"
{ 𝕤 ⋄ ∞ = 2 - 4 ÷ 4 - 2 } ts._Test "Right to left 3"


# Order of evaluation can be changed using ( and ).  Expressions within parentheses
# are evaluated first.

{ 𝕤 ⋄ ∞ = (2 × 3) - 1 } ts._Test "Reordering with parentheses"
{ 𝕤 ⋄ ∞ = ((1 + 3) × 2) ÷ 4 } ts._Test "Nested parentheses"


# = (Equals) is no exception to the order of evaluation, which is why koans
# with expressions of the left of = typically use parentheses.

{ 𝕤 ⋄ 3 + 5 = 8 } ts._Test "Equals is a Function"
{ 𝕤 ⋄ 9 ÷ 3 - 2 + 1 = 2 } ts._Test "Nested parentheses on left"
{ 𝕤 ⋄ 4 = 3 = 2 = 1 } ts._Test "Comparing truthiness"

ts.Report @
