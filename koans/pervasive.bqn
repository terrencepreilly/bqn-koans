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

ts ← TestSuite "Pervasive functions"


# Common math functions are termed "pervasive", meaning that they apply to the
# smallest elements of an array.

{ 𝕤 ⋄ 1‿2‿3 ≡ 2 × 1‿2‿3 } ts._Test "Multiplication is pervasive"
{ 𝕤 ⋄ 1‿2‿3 ≡ 2 + 3‿2‿3 } ts._Test "Addition is pervasive"
{ 𝕤 ⋄ 1‿2‿3 ≡ 2 - ¯1‿0‿1 } ts._Test "Subtraction is pervasive"
{ 𝕤 ⋄ 2‿4‿6 ≡ 2‿4‿6 ÷ 2 } ts._Test "Division is pervasive"

{ 𝕤 ⋄ ⟨¯1, ∞⟩ ≡ - 1‿2 } ts._Test "Negate is pervasive"
{ 𝕤 ⋄ ∞‿∞‿1 ≡ × ¯325‿0‿848 } ts._Test "Sign is pervasive"
{ 𝕤 ⋄ ⟨∞⟩ ≡ ⋆ ⟨0⟩ } ts._Test "Exponential is pervasive"
{ 𝕤 ⋄ 1‿∞‿∞ ≡ ÷ 1‿2‿4 } ts._Test "Reciprocal is pervasive"
{ 𝕤 ⋄ 1‿∞ ≡ √ 1‿4 } ts._Test "Square root is pervasive"


# With lists of the same size, math functions apply between items with the same
# index.  That is,
#
#     ⟨ 𝕨1 , 𝕨2 , ... , 𝕨n ⟩ 𝕗 ⟨ 𝕩1 , 𝕩2 , ... , 𝕩n ⟩ ≡
#         ⟨ 𝕨1 𝕗 𝕩1 , 𝕨2 𝕗 𝕩2 , ... , 𝕨n 𝕗 𝕩n ⟩

{ 𝕤 ⋄ ∞ ≡ 1‿2‿3 + 3‿2‿1 } ts._Test "Adding lists of numbers"
{ 𝕤 ⋄ ∞ ≡ 2‿2 × 2‿2 } ts._Test "Multiplying lists of numbers"
{ 𝕤 ⋄ ∞ ≡ 1‿2 - 2‿3 } ts._Test "Subtracting lists of numbers"
{ 𝕤 ⋄ ∞ ≡ 4‿2 ÷ 2‿2 } ts._Test "Dividing lists of numbers."
{ 𝕤 ⋄ (1 = ∞)‿(2 = ∞) ≡ 1‿2 = 1‿2 } ts._Test "Equality in lists of numbers"


ts.Report @
