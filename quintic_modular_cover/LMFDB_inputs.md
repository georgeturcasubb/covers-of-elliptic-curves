# Inputs for the quintic modular example

These inputs were retrieved from the read-only LMFDB SQL
mirror on 20 September 2026. The exact queries and returned rows are frozen
in [LMFDB_records.json](LMFDB_records.json) and
[LMFDB_elliptic_link.json](LMFDB_elliptic_link.json). The table descriptions and
sample rows were inspected before querying; array entries are recorded in
their original order. No live query is required to run the Magma scripts.

| Object | Primary record | Input used |
| --- | --- | --- |
| Source | [40.480.33.ck.1](https://www.lmfdb.org/ModularCurve/Q/40.480.33.ck.1/) | Row-major generators modulo 40; first parent is the target, with identity conjugator. |
| Target | [40.96.1.o.2](https://www.lmfdb.org/ModularCurve/Q/40.96.1.o.2/) | Row-major generators modulo 40; two rational cusps; Jacobian decomposition below. |
| Degree-five genus-zero cover | [5.5.0.a.1](https://www.lmfdb.org/ModularCurve/Q/5.5.0.a.1/) | Generators modulo 5 and exact map to the j-line. |
| Elliptic isogeny class | [800.d](https://www.lmfdb.org/EllipticCurve/Q/800/d/) | Correspondence with newform 800.2.a.d and representative `[0,0,0,100,0]`. |

The modular-curve web pages were unavailable to the web text retriever on
the access date; their records were successfully obtained from the LMFDB
SQL mirror. The elliptic isogeny-class web page was accessible.

The target's `gps_gl2zhat_fine` record contains

```text
label          = 40.96.1.o.2
rational_cusps = 2
cusp_orbits    = [[1,2],[2,3],[8,1]]
newforms       = [800.2.a.d]
dims           = [1]
mults          = [1]
curve_label    = null
```

Here `[d,m]` in `cusp_orbits` means `m` Galois orbits of size `d`.
Thus the rational-cusp input is explicitly distinct from the sixteen
geometric cusps computed by the coset action. The newform entry, dimension
and multiplicity give the modular target's Jacobian link to the elliptic
isogeny class. The class page's rank field alone would not establish that
link. The null `curve_label` is preserved: it supplies no identification of
the target with a particular Weierstrass representative.

Choosing one rational cusp as origin identifies the genus-one target with
its Jacobian. Rank is invariant under Q-isogeny. The companion uses

```text
E0 : y^2 = x^3 + 100*x,
P = (5,25),   2*P = (9/4,-123/8)
```

as a representative of class 800.d. Since E0 has integral short Weierstrass
coefficients and nonzero discriminant, Lutz–Nagell applied to the
nonintegral point 2P proves P is not torsion. A separate exact
2-isogeny descent in [elliptic_targets.m](../elliptic_targets.m) supplies
the algebraic upper bound; see [the rank note](../elliptic_targets.md).
No isogeny is composed with
the degree-five modular map, and no Q-isomorphism between the modular target
and E0 is asserted here.

The genus-zero `modcurve_modelmaps` record has degree 5, domain model type
1 and codomain model type 1. Its coordinate expressions are

```text
[x^5*(x-4*y)^3*(9*x^2+3*x*y+4*y^2), x^10]
leading_coefficients = [-2^2, 1]
```

After canceling the common homogeneous factor and putting `t=y/x`, this
is exactly

```text
j5(t) = -4*(1-4*t)^3*(9+3*t+4*t^2)
      = 4*(4*t-1)^3*(4*t^2+3*t+9).
```

The group script checks conjugacy between the source's mod-5 image and the
actual generators of `5.5.0.a.1`, printing the conjugator. This is necessary
to connect the displayed rational map to the level-40 fiber product.

The scripts recompute group orders, determinant images, containment of
`-I`, projective degrees, genera and cusp widths from the generators. The
frozen database's genus and width fields are comparison data, not the
algorithm's inputs for those computations. Rational-cusp and Jacobian
decomposition entries remain explicitly attributed database inputs; the
standalone group script does not recompute modular-form decompositions.

Attribution: The LMFDB Collaboration, *The L-functions and Modular Forms
Database*, the object records linked above, accessed 20 September 2026.
See [citation guidance](https://www.lmfdb.org/citation),
[source acknowledgments](https://www.lmfdb.org/acknowledgment), and
[license](https://www.lmfdb.org/license). The reproduced database extract
is attributed to LMFDB under CC BY-SA 4.0; formulas and the derived
coordinate change are identified above.
