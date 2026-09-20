# Covers of elliptic curves

Magma scripts accompanying *New algebraic points on covers of elliptic
curves*, by Diana Mocanu and George C. Țurcaș. This is a **private
prepublication companion**. No public release, DOI, or arXiv identifier is
assigned to it.

- `cubic_modular_cover/` checks the modular groups, original model and
  j-map transport, exact Kummer scalar, and normalized geometry for
  Lemma 6.1 and Proposition 6.2.
- `quintic_modular_cover/` checks the degree-five inclusion, arithmetic
  S5 and geometric A5, normalized ramification, and genus-65 resolvent
  for Proposition 6.3. Its input note records the rational-cusp and
  Jacobian isogeny-class data.
- `uniform_family/` checks selected instances of Proposition 6.4 and the
  boundary genera 10, 17, 24 in Remark 6.5. The general proof is in the paper.
- `bielliptic_X0N/` computes the quadratic-order class numbers used in
  Section 5 and separately computes the Fricke fixed-point counts.
- `elliptic_targets.m` proves algebraic rank one for both explicit
  elliptic representatives; `elliptic_targets.md` gives an elementary
  independent descent argument.

From this repository root, run any script with a local Magma installation:

```sh
magma -b cubic_modular_cover/group_theory_72.m
magma -b cubic_modular_cover/kummer_identification.m
magma -b cubic_modular_cover/kummer_geometry.m
magma -b quintic_modular_cover/group_theory_40.m
magma -b quintic_modular_cover/ramification.m
magma -b uniform_family/C_nm_checks.m
magma -b bielliptic_X0N/class_numbers.m
magma -b elliptic_targets.m
```

All eight scripts are self-contained, use exact arithmetic and assertions,
and need no network access or external packages. They were run successfully
with **Magma V2.28-9 on 20 September 2026**. Individual measured wall times
ranged from 0.036 to 1.033 seconds on the test machine; other machines and
Magma versions may differ. The accompanying `.out` files are genuine,
unedited successful output. Input notes beside the scripts give the original
LMFDB records, coordinate conventions, and mathematical scope. In particular,
the quintic target is used through its Q-isogeny class; no isomorphism to a
chosen representative is presumed.

Please cite the paper, the scripts used, and the relevant original LMFDB
records. See `CITATION.cff` for companion authorship and repository metadata,
and `LICENSE` for the retained author-code terms and LMFDB data attribution.
The repository is at
<https://github.com/georgeturcasubb/covers-of-elliptic-curves> and currently
requires authorized private access.
