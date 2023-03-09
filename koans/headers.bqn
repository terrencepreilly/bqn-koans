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

ts ← TestSuite "Headers"


# When a block becomes more complex, it can be more difficult to tell what the
# type of the function is. Headers are a means of communicating the type of a
# function block, and are separated from the block definition by a colon.
# Monadic functions can be documented like { 𝕊 𝕩 : ... }.

{ 𝕤 ⋄
  IsPositive ← { 𝕊 𝕩 : 𝕩 > 0 }
  0 = IsPositive 3
} ts._Test "Defining a monadic function"


# Dyadic funcitons can be documented similarly like { 𝕨 𝕊 𝕩 : ... }.

{ 𝕤 ⋄
  IsGreater ← { 𝕨 𝕊 𝕩 : 0 > 𝕩 - 𝕨 }
  2 IsGreater 7
} ts._Test "Defining a dyadic function"


# One modifiers use headers like { 𝕨 _𝕣 𝔽 𝕩 : ... }.

{ 𝕤 ⋄
  _Swap ← { 𝕨 𝔽 _𝕣 𝕩 : 𝕩 𝔽 𝕨 }
  ¯3 = 2 (- _Swap) 5
} ts._Test "Defining a one-modifier"


# Similarly, two-modifiers can be documented like { 𝕨 𝔽 _𝕣_ 𝔾 𝕩 : ... }.

{ 𝕤 ⋄
  _Atop_ ← { 𝕨 𝔽 _𝕣_ 𝔾 𝕩 :  𝔽 𝕨 𝔾 𝕩 }
  F ← - _Atop_ +
  ∞ = 3 F 2
} ts._Test "Defining a two-modifier"


# Multiple headers-body pairs can be specified for a block, separated by
# semicolons. The first matching header determines the body which is executed.
# The role of the function must still match the name it's assigned to, so we
# can't mix modifier and function headers.

{ 𝕤 ⋄
  Square ← {
   𝕊 𝕩 : 𝕩 ⥊˜ ⋈˜ √ ≠ 𝕩 ;
   𝕨 𝕊 𝕩 : 𝕨‿𝕨 ⥊ 𝕩
  }
  ({4 Square 𝕩} ≡ Square) 0‿2‿3‿5
} ts._Test "Monadic and dyadic verb in one"


# Beyond documenting the type of the block, the special symbols used in the
# header can be replaced by names to help document or distinguish them.

{ 𝕤 ⋄
  _Compare_ ← {
    Left _𝕣_ Right x : (Left x) ⋈ Right x
  }
  ∞ ≡ {𝕩 × 2} _Compare_ {𝕩 ÷ 2} 4
} ts._Test "Documenting arguments"

{
  𝕤 ⋄
  ∞ = ¯2 { Left : 𝕨 } 6
} ts._Test "Documenting function names"


# Alternatively, unneeded symbols can be trimmed from the header as long as
# the role of the block can be disambiguated.

{ 𝕤 ⋄
  Inc ← { 𝕊 : ¯1 + 𝕩 }
  3 = Inc 2
} ts._Test "Reducing noise"


# Parameters can also be replaced by values.  In that case, the header will
# only match when the given parameters match the values.

{ 𝕤 ⋄
  Or ← {
    0 𝕊 0 : 0 ;
    1 𝕊 0 : 1 ;
    0 𝕊 1 : 1 ;
    1 𝕊 1 : 1
  }

  ∞ ≡ 0‿0‿1‿1 Or¨ 0‿1‿0‿1
} ts._Test "Logical operator or"

{ 𝕤 ⋄
  And ← {
    𝕨 𝕊 𝕩 : 0
  }

  0‿0‿0‿1 ≡ 0‿0‿1‿1 And¨ 0‿1‿0‿1
} ts._Test "Logical operator and"

{ 𝕤 ⋄
  IsEmpty ← {
    𝕊 ⟨⟩ : 1 ;
    𝕊 𝕩 : 0
  }

  IsEmpty ⟨1⟩
} ts._Test "Matching a list"


# The values replacing parameters can also be destructured values.  That is,
# you can match against partial non-scalar values.

{ 𝕤 ⋄
  foodColors ← ⟨
    "green"‿"lettuce"
    "red"‿"tomato"
    "red"‿"apple"
    "yellow"‿"banana"
    "red"‿"cherry"
    "blue"‿"blueberry"
  ⟩
  IsRed ← {
    𝕊 "red"‿food : 1 ;
    𝕊 : 0
  }
  ∞ ≡ IsRed¨ foodColors
} ts._Test "Matching a partial list"


# To skip matching certain values, you can either use a name (in which case, the
# value will be assigned to the name), or you can use · (Nothing).  The values
# which match · will be ignored.

{ 𝕤 ⋄
  user ← ⟨ 1838 ⋄ "Georges"‿"Bizet"⟩
  IsBizet ← {
    𝕊 ⟨ · ⋄ ·‿"Buzzy" ⟩ : 1 ;
    𝕊 : 0
  }
  IsBizet user
} ts._Test "Using nothing"

{ 𝕤 ⋄
  IsEven ← {
    0 : 1 ;
    1 : 0 ;
    2 : 1 ;
    3 : 0 ;
    4 : 1
  }
  IsEven 3
} ts._Test "IsEven"


# Destructuring works well when matching specific values, but doesn't work for
# matching against ranges or matching against derived values. In that case, we
# can use predicates. Predicates use the format { header : predicate ? body }.
# The header can be dropped, as above.

{ 𝕤 ⋄
  Not ← { 𝕩? 0 ; 1 }
  Not 1
} ts._Test "Logical not"

{ 𝕤 ⋄
  ChangeLight ← {
    𝕊 "red" : "green" ;
    𝕊 "yellow" : "red" ;
    𝕊 "green" : "yellow"
  }

  light ← "green"
  ∞ ≡ ChangeLight ChangeLight ChangeLight "green"
} ts._Test "State machines"

{ 𝕤 ⋄

  ToDoInit ← ⟨⟩˙
  ToDoAdd ← {  time‿description 𝕊 todoList :
    ⟨0, time, description⟩‿todoList
  }
  ToDoNext ← {
    𝕊 ⟨0, ·, description⟩‿· : description ;
    𝕊 ⟨1, ·, ·⟩‿others : others ;
    𝕊 ⟨⟩ : ""
  }

  todoList ← 800‿"Pay Bills" ToDoAdd 930‿"Relax" ToDoAdd 1100‿"Walk dog" ToDoAdd ToDoInit ⟨⟩

  ∞ ≡ ToDoNext todoList
} ts._Test "ToDo lists"

ts.Report @
