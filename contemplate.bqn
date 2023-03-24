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

koans ← ⟨
  "basic_math"
  "order_of_evaluation"
  "monadic"
  "lists"
  "pervasive"
  "modifiers"
  "arrays"
  "assignment_and_roles"
  "combinators"
  "trains"
  "blocks"
  "headers"
  "under"
  "bind"
⟩

# ANSII Escape codes for colors.
red ← (27 + @) ∾ "[31m"
green ← (27 + @) ∾ "[32m"
clr ← (27 + @) ∾ "[0m"
qt ← """"
prefix ← "    "

ReportSingleSuccess ← {
  •Out ∾ prefix‿green‿"You have grasped the meaning of "‿qt‿𝕩‿qt‿"."‿clr
}
ReportSingleFailure ← {
  •Out ∾ prefix‿red‿"Think upon the meaning of "‿qt‿𝕩‿qt‿"."‿clr
}
ReportAllPass ← {𝕤
  •Out ∾ green‿"All koans completed!"‿clr
}
Report ← {𝕤
  title‿successes‿failures ← ⊑ 𝕩
  •Out "Contemplate clearly " ∾ title ∾ "."
  ReportSingleSuccess¨ successes

  # We only want to report a single failure, if there is one.
  # That way, users can focus on the next step, only.
  failure ← (0 < ≠)◶⟨⟩‿(1⊸↑) failures
  ReportSingleFailure¨ failure
}

# Given a list of koans, executes the koans and returns the
# lists of titles/successes/failures.
ExecuteTests ← {
  ExecuteSingleTest ← {
    title‿successes‿failures ← •Import∘("koans/"⊸∾ ∘ ∾⟜".bqn") 𝕩
    < title‿successes‿failures
  }
  ExecuteSingleTest¨ 𝕩
}


{
  reports ← ExecuteTests 𝕩

  HasFailure ← (0 < ≠)∘(2⊸⊑)∘⊑¨
  filesPassed‿filesWithFailures← (∨´ ∘ HasFailure)◶(reports‿⟨⟩)‿(HasFailure ⊔ ⊢) reports

  Report¨ filesPassed
  ((0 = ≠)◶(Report∘⊑)‿ReportAllPass) filesWithFailures

  # TODO: Print the file name which should be read.

  successes ← +´ ≠∘(1⊸⊑)∘⊑¨ reports
  failures ← +´ ≠∘(2⊸⊑)∘⊑¨ reports

  •Out ∾ ⟨
      "You are "
      (•Repr successes)
      "/"
      (•Repr failures + successes)
      " koans and "
      (•Repr ≠ filesPassed)
      "/"
      (•Repr ≠ reports)
      " lessons along the path to enlightenment.
      "
  ⟩
} koans
