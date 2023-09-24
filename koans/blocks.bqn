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

ts ← TestSuite "Blocks"

# Blocks are sections of code surrounded by {}. Blocks are a means of explicit
# programming. (That is, non-tacit, or non-point-free programming.)  What a
# block represents depends, in part, on whether that block contains the special
# characters 𝕩, 𝕏, 𝕨, 𝕎, 𝕗, 𝔽, 𝕘, 𝔾, 𝕣, 𝕤 and 𝕊.  Blocks can be used to introduce
# scope, define objects, and create functions.
#
# A block which contains none of the above special characters is an "immediate
# block", and is evaluated immediately. This can be used, among other things,
# to introduce a new lexical scope. This means that variables defined within
# the block are not accessible outside of the block.

{ 𝕤 ⋄
  a ← "Out of the block"
  {
    a ← "Inside of the block"
  }
  ∞ ≡ a
} ts._Test "One level of blocks"

{ 𝕤 ⋄
  a ← "Outermost block"
  {
    a ← "Outer block"
    {
      a ← "Inner block"
      {
        a ← "Innermost block"
      }
    }
  }
  ∞ ≡ a
} ts._Test "Four levels of blocks"


# A block can access its surrounding scope; variables which are not defined
# within a block will resolve to the nearest surrounding scope. You can't use
# ← to update a variable in an outer scope; ← will define a new variable in
# this scope. To update a variable in a surrounding scope, you must make use
# of the ↩ operator, which updates an existing variable.

{ 𝕤 ⋄
  a ← "Outside"
  {
    a ↩ "Inside"
  }
  ∞ ≡ a
} ts._Test "Outside inside"


# This can be useful for updating a variable without cluttering the outer scope.
# π here is pi, or approximately 3.14159265358.

{ 𝕤 ⋄
  radius ← 1 ÷ π
  height ← 2
  cylinder_surface_area ← 0
  {
    circle_surface_area ← π × radius ⋆ 2
    circle_circumference ← 2 × π × radius
    rect_surface_area ← circle_circumference × height
    cylinder_surface_area ↩ rect_surface_area + 2 × circle_surface_area
  }
  expected ← ∞
  expected = cylinder_surface_area
} ts._Test "Keeping things clean"

{ 𝕤 ⋄
  seq ← 0
  {
      nums ← 4‿∘ ⥊ ⟨
        1, 0, 0, 0
        2, 3, 0, 0
        4, 5, 6, 0
        7, 8, 9, 10
      ⟩
      seq ↩ +˝ nums
  }
  ∞ ≡ seq
} ts._Test "Building a sequence"


# To define a function using a block, you can simply use the special name, 𝕩.
# 𝕩 represents the right-hand argument. If the block contains at least one 𝕩, then
# it describes a monadic function. Statements in the block are separated by
# any of the list separators. The last statement in the block is the return
# value.

{ 𝕤 ⋄ ∞ = {- 𝕩} 1 } ts._Test "Simple block"

{ 𝕤 ⋄ ∞ = {𝕩 + 𝕩} 1 } ts._Test "Addition block"

{ 𝕤 ⋄
  ∞ = { a ← 𝕩 ⋆ 2 , 3 + a } 2
} ts._Test "Multiple statements with comma separator"

{ 𝕤 ⋄
  ∞ = { a ← 𝕩 ⋆ 3 ⋄ a - 4 } 2
} ts._Test "Multiple statements with diamond separator"

{ 𝕤 ⋄
  ∞ = {
    a ← 𝕩
    - a
  } 2
} ts._Test "Multiple statements with newline separator"

{ 𝕤 ⋄
  a ← 0
  {
    a ↩ a + 𝕩
  } 5
  ∞ = a
} ts._Test "Redefining in a scope"


# Like other function definitions, blocks can be assigned to a variable.

{ 𝕤 ⋄
  NegateOverLengthExplicit ← { 𝕩 }
  NegateOverLength ← -○≠
  (NegateOverLength ≡ NegateOverLengthExplicit) 1‿2‿3‿4
} ts._Test "Negating over"

{ 𝕤 ⋄
  Double ← { 𝕩 × 2 }
  ∞‿∞‿∞ ≡ Double 7‿0.5‿¯2
} ts._Test "Assigning a block"

{ 𝕤 ⋄
  count ← 0
  Inc ← { count ↩ count + 𝕩 }
  Inc 1
  Inc 1
  Inc 1
  ∞ = count
} ts._Test "Maintaining a counter."


# ↩ has a special syntax for updates where the new value references the
# existing value: 𝕩 𝔽↩ 𝕨 is equivalent to 𝕩 ↩ 𝕩 𝕗 𝕨.

{ 𝕤 ⋄
  count ← 1
  Acc ← { count ↩ 𝕩 }  # Hint: Update this function.
  Acc 2
  Acc 2
  Acc 2
  8 = count
} ts._Test "Maintaining a counter with ↩"


# A block which contains 𝕨 defines a dyadic function, where 𝕨 refers to
# the left argument.

{ 𝕤 ⋄
  ∞ = 2 { 𝕨 × 𝕩 } 3
} ts._Test "Simple dyadic function"

{ 𝕤 ⋄
  Left ← { 𝕩 }
  3 (⊣ = Left) 1
} ts._Test "Implement left"

{ 𝕤 ⋄
  ∞ = 2 { 𝕩 - 𝕨 } 3
} ts._Test "Rearranging arguments"

{ 𝕤 ⋄
  ∞ ≡ 2 { 𝕩‿𝕨‿𝕩‿𝕨 } 3
} ts._Test "Making a list"

{ 𝕤 ⋄
  ∞ ≡ 4 { 𝕨 × ÷ 𝕩 } 2‿4‿1
} ts._Test "List arguments"

{ 𝕤 ⋄
  PairOverLengthExplicit ← { (≠ 𝕨) ⋈ ≠ 𝕩 }
  PairOverLength ← ⋈○≠
  ⟨1⟩ (PairOverLength ≢ PairOverLengthExplicit) 1‿2‿3‿4
} ts._Test "Replicating dyadic over"


# The arguments 𝔽 and 𝔾 are similar to 𝕨 and 𝕩, in that they refer to the left
# and right arguments, respectively. But 𝔽 and 𝔾 refer to functions. If a
# block contains 𝔽 (and no 𝔾), then it defines a 1-modifier. If a block
# contains a 𝔾, then it defines a 2-modifier.

{ 𝕤 ⋄
  _Id ← { 𝔽 }
  ∞ = 2 ×_Id 3
} ts._Test "Identity modifier"

{ 𝕤 ⋄
  _Swap ← { 𝕩 𝔽 𝕨 }
  ∞ = 2 -_Swap 3
} ts._Test "Swap"

{ 𝕤 ⋄
  _Twice ← { 𝔽 𝔽 𝕩 }
  ∞ = -_Twice 1
} ts._Test "Apply twice"

{ 𝕤 ⋄
  _Both ← { 𝕩 𝔽 𝕩 }
  ∞ = ×_Both 2
} ts._Test "Both"

{ 𝕤 ⋄
  _Atop_ ← { 𝔽 𝕨 𝔾 𝕩 }
  ∞ = 2 - _Atop_ × 3
} ts._Test "Atop combinator"

{ 𝕤 ⋄
  _Over_ ← { (𝔾 𝕨) 𝔽 𝔾 𝕩 }
  ∞ = 2 - _Over_ ÷ 4
} ts._Test "Over combinator"


# The remaining special symbols, 𝕤/𝕊 and 𝕣 are self-reference symbols,
# and so they allow for recursion.  𝕤 and 𝕊 are used in functions, while
# 𝕣 is used in modifiers.
#
# In order to use 𝕤, 𝕊 or 𝕣 without infinite recursion, we'll need a means
# of control flow.  The 2-modifier ◶ (Choose), uses the left function as
# an index to choose one of the right functions.

{ 𝕤 ⋄
  ∞ = 1 0˙◶+‿- 1
} ts._Test "Choosing the first function"

{ 𝕤 ⋄
  ∞ = 1 1˙◶+‿- 1
} ts._Test "Choosing the second function"

{ 𝕤 ⋄
  ∞ = 1 <◶-‿-˜ 2
} ts._Test "Making things always positive"

# Now we can use 𝕊 to call the original function with new arguments
# (to recurse) until we reach the base case.

{ 𝕤 ⋄
  SumTo ← { 𝕨 {0 = 𝕩}◶({𝕨 + 𝕩} 𝕊 {𝕩 - 1})‿{𝕨} 𝕩 }
  ∞ = 0 SumTo 3
} ts._Test "Sum from 1 to n - 1"

# Alternatively, we could use the function name itself to perform recursion.
# This can allow keeping most of the definition tacit. However, it won't work
# in a function which is given no name. And if the function name is changed,
# all references to it must also be updated.

{ 𝕤 ⋄
  # Hint: Replace a function with "Spread" to make this recursive.
  Spread ← (0 = ⊣)◶{ (𝕨 - 1) × (𝕨 ∾ 𝕩) }‿⊢
  1‿2‿3 ≡ 3 Spread ⟨⟩
} ts._Test "Recurse with explicit self-reference"


ts.Report @
