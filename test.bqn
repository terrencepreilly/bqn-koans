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


# The basic unit-testing machinery necessary for Koans.

# A test suite representing a collection of koans.
# The first failing koan is displayed in the report.
TestSuite ⇐ {
  title ⇐ 𝕩
  rand ← •MakeRand •UnixTime @

  successes ← ⟨⟩
  Success ← { successes ∾↩ ⟨𝕩⟩ }

  failures ← ⟨⟩
  Failure ← { failures ∾↩ ⟨𝕩⟩ }

  Report ⇐ {𝕤
    title‿successes‿failures
  }

  # A 1-modifier that describes a test.  It takes a test function,
  # which must return 0 or 1.  It then generates a function which will
  # print the passing message, if the test passes, or the failing message
  # if the test fails.
  #
  # Example:
  #   { 𝕤 ⋄ 2 = 1 + 1 } _Test "Addition"
  _Test ⇐ {
    (1 = 𝔽 @)◶⟨Failure, Success⟩
  }
}
