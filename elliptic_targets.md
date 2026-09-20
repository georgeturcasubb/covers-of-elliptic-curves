# The two elliptic representatives

The following are already minimal Weierstrass models over Q:

| Equation | Conductor | Discriminant | Cremona label | LMFDB label | Rank | Torsion |
|---|---:|---:|---|---|---:|---|
| `y^2=x^3+8` | 576 | -27648 | 576a1 | 576.e4 | 1 | Z/2 |
| `y^2=x^3+100x` | 800 | -64000000 | 800a4 | 800.d4 | 1 | Z/2 |

`elliptic_targets.m` constructs these equations from coefficients. It checks
minimal models, conductors, torsion and algebraic rank upper bounds via
`TwoPowerIsogenyDescentRankBound` with `MaxSteps:=1`. The explicit points
`(1,3)` and `(5,25)` double to `(-7/4,-13/8)` and `(9/4,-123/8)`, respectively.
On an integral short Weierstrass model every rational torsion point is
integral by Nagell--Lutz. The nonintegral doubles therefore prove the lower
bound one. See J. S. Milne, *Elliptic Curves*, Chapter II, Theorem 5.1,
[author's text](https://jmilne.org/math/Books/ectext6.pdf).

The output was produced using Magma V2.28-9 on 2026-09-20, in
0.077008 seconds elapsed. Both algebraic rank bounds are `[1,1]`.
The [Magma handbook](https://magma.maths.usyd.edu.au/magma/handbook/text/1570)
describes the direct 2-isogeny routine as giving a rank upper bound without
class-group or unit calculations. No analytic rank, GRH, BSD or parity
assumption is used. The Cremona references printed by Magma differ from
the LMFDB labels, whose correspondence is recorded in
[576.e4](https://www.lmfdb.org/EllipticCurve/Q/576/e/4) and
[class 800.d](https://www.lmfdb.org/EllipticCurve/Q/800/d/).
All linked sources were accessed on 2026-09-20.

## An independent elementary descent

For `E(a,b): y^2=x(x^2+a*x+b)`, put `E'=E(-2a,a^2-4b)`.
The descent homomorphism `alpha:E(Q)->Q*/Q*^2` sends an ordinary point to
its `x` squareclass, infinity to `1`, and `(0,0)` to `b`. Its image consists
of squareclasses represented by signed squarefree divisors `d` of `b`;
membership requires a solution

```
N^2=d*U^4+a*U^2*V^2+(b/d)*V^4,  gcd(U,V)=1.
```

For the analogous map `alpha'` on `E'`,
`2^rank(E(Q))=|im(alpha)|*|im(alpha')|/4`.
These are the standard formulas for 2-isogeny descent; see J. E. Cremona,
*Algorithms for Modular Elliptic Curves*, second edition, Section 3.6,
pp. 84--86, equation (3.6.2),
[author's Chapter III](https://johncremona.github.io/book/fulltext/chapter3.pdf).

For the cubic representative, set `X=x+2` to obtain `E(-6,12)`.
The factor `X^2-6X+12=(X-3)^2+3` is positive, so its image lies in
`{1,2,3,6}`. The point `(0,0)` supplies class `3`. Class `2` would require
`N^2=2U^4-6U^2V^2+6V^4`. Modulo 3 this forces `3|U,N`, after which
primitivity makes the right side have 3-adic valuation one, a contradiction.
The group law excludes class `6` too, so the image has order two.
The dual `E(12,-12)` has candidate classes `{1,-1,2,-2,3,-3,6,-6}`;
`(0,0)` and `(-2,8)` supply `-3` and `-2`, generating
`{1,-2,-3,6}`. Class `-1` would require
`N^2=-U^4+12U^2V^2+12V^4`, excluded by the same modulo-3 and valuation
argument. Its entire coset is excluded. The two image orders are two and
four, so the rank is one.

For the quintic representative `E(0,100)`, positivity restricts the image
to `{1,2,5,10}`, and `(5,25)` supplies class `5`. Class `2` would require
`N^2=2U^4+50V^4`. Modulo 5 this forces `5|U,N`; substituting
`U=5u,N=5n` gives `n^2=50u^4+2V^4`, impossible modulo 5 because `V`
is a unit and `2` is not a square. Class `10` is excluded by the group
law. The dual `E(0,-400)` has candidate classes `{1,-1,2,-2,5,-5,10,-10}`.
Its points `(20,0)` and `(-20,0)` supply `5` and `-5`, generating
`{1,-1,5,-5}`. Class `2` would require `N^2=2U^4-200V^4`; the same
substitution gives `n^2=50u^4-8V^4`, again reducing to `2V^4` modulo 5.
The other coset is excluded. The image orders are again two and four,
giving rank one.

## Relation to the quintic modular target

The equation `y^2=x^3+100x` is a representative of Q-isogeny class `800.d`.
The modular-record link and rational cusp are established in
`quintic_modular_cover/LMFDB_inputs.md`. Choosing that cusp as origin gives
an elliptic curve whose rank is one, since Q-isogenous elliptic curves
have the same Mordell--Weil rank. This argument does not identify the
modular target itself as Q-isomorphic to `800.d4`.
