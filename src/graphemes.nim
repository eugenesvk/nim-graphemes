## This module provides support to
## handle unicode grapheme clusters

import unicode

from graphemes/private/grapheme_break import graphemeType

# Auto generated with github@nitely/regexy
# See ../gen/gen_re.nim for the original regex
const DFA = [
  [1'i8, 21, 10, 13, 12, 11, 8, 25, 7, 22, 1, 14, 24, 23, 15, 20, 18, 17, 9],
  [1'i8, -1, 5, -1, -1, 6, 4, -1, 3, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, 2, -1, 2, -1, 5, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, 2, -1, 2, -1, 10, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, 2, -1, 2, -1, 10, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, 14, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, 15, 16, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, 16, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, 17, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, 18, 19, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, 19, -1],
  [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, 14, -1, -1, 15, 20, 18, -1, -1],
  [1'i8, 2, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, 21, 10, 10, 2, 2, 2, -1, 2, 22, 1, 14, -1, -1, 15, 20, 18, 17, 2],
  [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 23, -1, -1, -1, -1, -1],
  [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
]

iterator graphemes*(s: string): string {.inline.} =
  ## Iterates over any grapheme (i.e user perceived character)
  ## of the string text returning graphemes
  var
    state = DFA[0]
    r: Rune
    a, b, n = 0
  while n < s.len or a < b:
    while n < s.len:
      fastRuneAt(s, n, r, true)
      let
        t = graphemeType(int(r))
        idx = state[t]
      if idx == -1:
        state = DFA[DFA[0][t]]
        break
      b = n
      state = DFA[idx]
    assert b > a
    yield s[a ..< b]
    a = b
    b = n

proc graphemes*(s: string): seq[string] =
  ## Return a sequence containing the graphemes in text
  result = newSeqOfCap[string](s.len)
  for c in graphemes(s):
    result.add(c)
