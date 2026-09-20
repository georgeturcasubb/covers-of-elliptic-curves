# Reproducing the quintic calculations

Both scripts are standalone Magma inputs with no external packages or
downloaded dependencies. From this directory, run

```sh
magma -b group_theory_40.m
magma -b ramification.m
```

These are portable reproduction commands. The recorded runs used Magma's
`-b` batch option; the executable statements are unchanged, while introductory
comments have been shortened. The `.out` files are unedited captured stdout.

Software was **Magma V2.28-9**, executable `/Applications/Magma/magma`,
on macOS/arm64. Its SHA-256 was
`e1802f3324f8df0996140e6babeba326b9f26b29d2413403f6165f9e0a17a9a6`.
Both runs exited 0 without timeout, with empty stderr and no errors in
stdout. Completion sentinels were checked in addition to error-free output.

| Input | UTC start | UTC finish | Elapsed seconds |
| --- | --- | --- | ---: |
| `group_theory_40.m` | 2026-09-20T19:40:37.620093Z | 2026-09-20T19:40:37.801996Z | 0.181881 |
| `ramification.m` | 2026-09-20T19:42:16.720711Z | 2026-09-20T19:42:16.760685Z | 0.039954 |

```text
SHA-256 of the distributed scripts (introductory comments shortened)
group_theory_40.m
00311197919a00485eb7aca6e6ceeed4a24154fa4f747addddbce3bcf7de283f
ramification.m
c53a4e1c27d154302fb892d874ba1f84c452369ecefd7d09406295465a9ace7a

SHA-256 of genuine standard output
group_theory_40.out
bc3ae8447fbe62ba5865b81511309d916944af1bf451d0dcd28e7ecd4d436d94
ramification.out
7af802cc056c3c6833673579fc12519f405fc21948b46325fc9637a05fbadfae
```

The genus is computed by two compatible methods: the source's S/R/T coset
orbits and Riemann–Hurwitz after normalized base change of the exact j-map.
The latter script also constructs the ten-letter resolvent action.

Rational-cusp and Jacobian/newform identifications are attributed inputs
documented in [LMFDB_inputs.md](LMFDB_inputs.md). The rank lower bound uses
an explicit point and Lutz–Nagell, not a numerical analytic-rank estimate.
The separate [elliptic rank calculation](../elliptic_targets.m) supplies
the algebraic upper bound; see [the rank note](../elliptic_targets.md).
