# Inputs for the cubic modular cover

The scripts use a saved LMFDB extract retrieved on **22 July 2026 at
19:13:43 UTC**, rather than an unrecorded live query. The source groups and
model/map rows were obtained from `gps_gl2zhat_fine`, `modcurve_models` and
`modcurve_modelmaps`, after inspecting their schemas and sample rows. The
original query and extract are retained in the authors' private working
archive. The extract has SHA-256
`61ca31cb3fd7f1d890fabac19ed83f3d90097f0b78dfd5db1acc6066f45dfb56`;
the query has SHA-256
`95a38071e9fd5f3f25d5f2cd308447804402c8a0eda6ae9c3af7aedf56aa57ac`.
These hashes matched the original saved manifest when inspected on
20 September 2026. A web retrieval of the genus-two record on that date was
unavailable; no fresh live verification of the model rows is claimed.

The LMFDB data are attributed to the LMFDB Collaboration; see its
[citation guidance](https://www.lmfdb.org/citation) and
[data licence](https://www.lmfdb.org/api/options/). The formulas copied from
the database are distinguished below from the derived identities checked by
the scripts.

## Groups and conventions

All matrices are row-major. Conjugation is `G^c = c^(-1) G c`.

| Curve | Role | Generators in the saved display convention |
|---|---|---|
| [72.216.13.h.1](https://www.lmfdb.org/ModularCurve/Q/72.216.13.h.1/) | source, level 72 | `[16,33,51,10]`, `[36,29,47,54]`, `[44,21,39,38]`, `[63,10,34,45]`, `[67,48,30,61]` |
| [24.72.1.h.1](https://www.lmfdb.org/ModularCurve/Q/24.72.1.h.1/) | target, level 24 | `[5,15,18,7]`, `[7,0,12,17]`, `[11,6,18,17]`, `[19,0,18,5]`, `[19,12,6,11]` |
| [8.6.0.b.1](https://www.lmfdb.org/ModularCurve/Q/8.6.0.b.1/) | common level-8 factor | `[3,1,2,7]`, `[3,1,4,3]`, `[3,4,4,5]` |
| [9.36.2.a.1](https://www.lmfdb.org/ModularCurve/Q/9.36.2.a.1/) | genus-two factor | `[2,6,6,2]`, `[4,0,0,2]` |
| [3.12.0.a.1](https://www.lmfdb.org/ModularCurve/Q/3.12.0.a.1/) | split Cartan `X_sp(3)` | `[1,0,0,2]`, `[2,0,0,2]` |

The source row records the factors `8.6.0.b.1` and `9.36.2.a.1`;
the target row records `3.12.0.a.1` and `8.6.0.b.1`. The stored parent
conjugator uses a canonical convention and should not be applied blindly to
the display generators. For the displayed lists above the script verifies
the compatible target conjugator `[16,1,1,17]` modulo 24. It also checks the
local projections against the separately saved groups, their CRT products,
and the inverse-image equality at level 72.

The split Cartan has index 12. It is **not** the index-6 split-Cartan
normalizer. Although `J(U)` below has degree 6 as a rational function of `U`,
the invariant field is `Q(U,v)`, quadratic over `Q(U)`.

## Original genus-two models and maps

Model 301 (type 8) for `9.36.2.a.1` has homogeneous coordinates
`(X:Y:Z:W)` and the following six equations, copied literally apart from
capitalization:

```text
X*Y*W-X*Z*W+W^3
X*Y*Z-X*Z^2+Z*W^2
X*Y^2-X*Y*Z+Y*W^2
X^2*Y-X^2*Z+X*W^2
Y^3-Z^3+6*X*Y*W+3*X*Z*W-3*W^3
6*X^2*Y+3*X^2*Z-Y^2*W-Y*Z*W-Z^2*W-3*X*W^2
```

Model 303 (type 5) is the weighted Weierstrass model, with weights `(1,3,1)`:

```text
a^3*v + 5*a^3*z^3 + v^2 + v*z^3 + 7*z^6 = 0.
```

The original degree-one map 465 is

```text
(X:Y:Z:W) -> (X : -X^3 + X*Z*W/3 - 5*W^3/27 : W/3).
```

On the dense chart `z=1`, a derived inverse uses `W=3` and

```text
X=a, Y=27*a^2/(v^2+v+7), Z=-9*(v+2)*a^2/(v^2+v+7).
```

The embedded coordinate `W` is unrelated to the later Kummer generator `w`.
The script substitutes this inverse into all six original equations and
checks that map 465 returns `(a,v,1)`.

The original absolute j-map 463 has degree 36 and is `27*A/B`, where the
factor 27 comes from the stored `leading_coefficients` field `[3^3,1]`:

```text
A = 81*X^4*W^4 - 54*X*Z^6*W + 3*X*Z^3*W^4
    + 9*Y^2*Z^6 + 57*Y^2*Z^3*W^3 - Y^2*W^6
    + 57*Y*Z^4*W^3 - 2*Y*Z*W^6
    + 57*Z^5*W^3 - 3*Z^2*W^6;
B = W^4*(3*X*Z^3 - Y^2*W^2 - 2*Y*Z*W^2 - 3*Z^2*W^2).
```

The identity `27*A/B=J(a^3)` is derived by exact reduction using
`v^2+(a^3+1)*v+5*a^3+7=0`, where

```text
J(U)=(U-9)^3*(U+3)^3/U^3.
```

For comparison, original map 7 for `3.12.0.a.1` is the coordinate pair

```text
[x^15*(x+6*y)^3*(x^2-6*x*y+36*y^2)^3,
 y^3*x^12*(x-3*y)^3*(x^2+3*x*y+9*y^2)^3].
```

Canceling the common factor and writing `t=x/y` gives
`((t^4+216*t)/(t^3-27))^3`. The script checks this equals `J(a^3)` for
`t=-v-2` and `a^3=(t^2+3*t+9)/(t-3)`.

The determinant-one normalizer quotient computed in `group_theory_72.m`
is the deck group of the genus-two cover over the geometric j-line. Its
unique subgroup of order three identifies the modular reduction quotient
with `(a,v) -> (zeta_3*a,v)`. This is a geometric automorphism; it is not
asserted to be a rational deck transformation over Q. Taking the invariant
field gives the rational subfield `Q(a^3,v)`.

## Target model and scalar

Original model 10203 for `24.72.1.h.1` is
`x^3-y^2*z+8*z^3=0`. Original map 10595 has degree 72 and coordinate pair

```text
[(y^2+24*z^2)^3*(y^6+1800*y^4*z^2-25920*y^2*z^4+124416*z^6)^3,
 z^2*y^6*(y^2-72*z^2)^6*(y^2-8*z^2)^2]
```

with stored leading coefficients `[1,2^3]`; thus its denominator is
multiplied by 8. In `z=1`, put `s=y^2=x^3+8` to obtain

```text
jE=(s+24)^3*(s^3+1800*s^2-25920*s+124416)^3 /
   (8*s^3*(s-72)^6*(s-8)^2).
```

The remaining identities in `kummer_identification.m` are derived, not
copied database data. Exact factorization of `J(U)=jE` gives two linear
factors and two irreducible quadratic factors over `Q(E)`. With

```text
h=(x+2)*(x^2+4*x+16)/(x*(x-4)*(x^2-2*x+4)),
q=-3*x*(x-4)/(x^2+4*x+16),
U1=-54*x^2*(x-4)^2*(x+2)/((x^2+4*x+16)^2*(x^2-2*x+4)),
U2=-27/U1,
```

the script verifies `U1=2*h*q^3` and `U1*U2=(-3)^3`. Therefore either
possible modular root gives the same cubic extension
`Q(E)(cube_root(2*h))`. This does not assert that both roots lift the
auxiliary coordinate `v`.

`kummer_geometry.m` computes the divisor of `h` and the normalized
ramification, including infinity. It computes degree 3 independently from
the function-field extension and proves geometric integrality using the
valuation 2 at the rational point at infinity. The resulting inclusion of
function fields over Q extends uniquely to a finite map of smooth projective
curves. There is no unresolved map base point in that interpretation.

The separate [elliptic target script](../elliptic_targets.m) and
[rank note](../elliptic_targets.md) certify algebraic rank one for E.
Database model/map rows
have null `upload_id` fields, so those fields provide no additional
upstream software-version or authorship information.

## Running the checks

Run `magma -b group_theory_72.m`, `magma -b kummer_identification.m`, and
`magma -b kummer_geometry.m` from this directory. They need no external code
or network access. The accompanying `.out` files are unedited output from
successful local Magma V2.28-9 runs on 20 September 2026. The recorded CPU
times were respectively 0.170, 0.070 and 0.950 seconds; runtimes on other
machines may differ.
