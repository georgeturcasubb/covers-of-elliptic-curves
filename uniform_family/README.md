# Uniform family checks

`C_nm_checks.m` checks selected instances of the family in Section 6:

\[
E:y^2=x^3-2,\qquad C_{n,m}:z^n-nz=x^m.
\]

The input range is `n=3,4,5`, `n+2 <= m <= n+6`, together with
`(3,4)`, `(4,5)`, `(5,6)`. These finite computations support the manuscript's
proof; they do not prove its general statement.

The script finds the critical points of `z^n-nz` over a cyclotomic field and
factors the corresponding fibres. At a branch value `c`, it computes

\[
k=\deg\gcd(x^m-c,x^3-2).
\]

There are `2(m-k)` unramified points of `E` over `c`, and `k` points with
base-change index 2. A ramification index `r` becomes `gcd(r,e)` branches
of index `r/gcd(r,e)` after normalization of a tame base change of index
`e`. Applying this rule to the factored fibres, and separately at infinity,
gives the degree of the different and hence the genus. A raw polynomial
discriminant is not used in place of the normalized trace-discriminant
divisor.

For `(5,6)`, the common finite branch value is `c=4`, and the gcd has
degree 3. The three points with base index 2 contribute no different to
the normalized degree-five cover; the other six points contribute 6.
The other three critical values contribute 36 in total. Infinity contributes
4, so Riemann--Hurwitz gives `g=1+(6+36+4)/2=24`.
At the elliptic origin the Newton polygon of `Z^5-5Z-x^6` has its single
slope `12/5`. Its denominator 5 proves irreducibility over the geometric
local field and hence geometric connectedness and degree 5. In the
noncollision cases, connectedness follows from the disjoint finite branch
loci argument in the manuscript.

The second genus calculation uses Magma function fields for all three
boundary cases and for the cubic quartic-block resolvent at `m=5,6`, without
assuming the constant field is exact. A returned constant-field degree 1,
together with irreducibility checked by the constructor, certifies geometric
connectedness. The script also derives the quartic block-resolvent polynomial
from four formal roots and computes inertia in the actual actions on three
pair-partitions and on ten two-element subsets, including infinity.

Run `magma -b C_nm_checks.m` from this directory. Tested with Magma
V2.28-9 on 2026-09-20, in 0.288 seconds, with exit status 0 and empty
stderr. `C_nm_checks.out` is the unedited stdout from the successful
execution. All 18 selected instances passed; the independently computed
function-field genera of the three boundary models were `10,17,24`, each
with exact constant-field degree 1. The quartic cubic resolvent had genera
`16,19` at `m=5,6`, respectively, also with exact constant-field degree 1.

The script has SHA-256
`0732f6cace947c9d464c81e30cfdf09b229dd833fd937339ee5532b12f7e7065`.
