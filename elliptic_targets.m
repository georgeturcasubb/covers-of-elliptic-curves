/*
Elliptic targets used in Section 6.
The points (1,3) on y^2=x^3+8 and (5,25) on y^2=x^3+100*x are
non-torsion by Nagell--Lutz: their doubles are nonintegral.
An algebraic 2-isogeny descent gives rank upper bound one in both cases.
The quintic curve here is an isogeny-class representative; its identification
with the modular target's Jacobian is addressed separately.

Magma V2.28-9, 2026-09-20: 0.077008 seconds elapsed for the original
standalone job with this executable body; elliptic_targets.out is its output.
No external packages or conditional arithmetic assumptions are used.
See elliptic_targets.md for an independent elementary descent proof.
*/
SetSeed(20260920);
Q := Rationals();
print "ELLIPTIC_RANK_BEGIN";
print "MAGMA_VERSION", GetVersion();

inputs := [*
    <"cubic", [Q|0,0,0,0,8], [Q|1,3,1],
      [Q|-7/4,-13/8,1], [Q|-2,0,1]>,
    <"quintic_isogeny_representative", [Q|0,0,0,100,0], [Q|5,25,1],
      [Q|9/4,-123/8,1], [Q|0,0,1]>
*];

for input in inputs do
    name, ainvs, pcoords, doublecoords, tcoords := Explode(input);
    print "CURVE_BEGIN", name;
    E := EllipticCurve(ainvs);
    assert Discriminant(E) ne 0;
    P := E!pcoords;
    P2 := 2*P;
    assert P2 eq E!doublecoords;
    assert Denominator(P2[1]/P2[3]) gt 1;
    print "INPUT_AINVARIANTS", aInvariants(E);
    print "POINT_P", P;
    print "POINT_2P", P2;
    print "DOUBLE_X_DENOMINATOR", Denominator(P2[1]/P2[3]);
    print "NAGELL_LUTZ_LOWER_BOUND", 1;

    Emin, to_min := MinimalModel(E);
    print "MINIMAL_AINVARIANTS", aInvariants(Emin);
    print "MINIMAL_ISOMORPHISM", DefiningPolynomials(to_min);
    print "MINIMAL_POINT_P", to_min(P);
    print "DISCRIMINANT", Discriminant(E);
    print "MINIMAL_DISCRIMINANT", Discriminant(Emin);
    print "CONDUCTOR", Conductor(E);
    print "J_INVARIANT", jInvariant(E);
    print "LOCAL_INFORMATION", LocalInformation(E);
    Tors, tors_to_E := TorsionSubgroup(E);
    print "TORSION_INVARIANTS", Invariants(Tors);
    print "TORSION_POINTS", [tors_to_E(t) : t in Tors];
    assert #Tors eq 2;
    print "POINT_ORDER_ZERO_MEANS_INFINITE", Order(P);
    assert Order(P) eq 0;

    T := E!tcoords;
    assert T ne E!0 and 2*T eq E!0;
    print "DESCENT_TWO_TORSION_POINT", T;
    SetVerbose("cbrank", 1);
    upper, dims, dual_dims := TwoPowerIsogenyDescentRankBound(
        E, T : MaxSteps := 1, Cutoff := 2);
    SetVerbose("cbrank", 0);
    print "TWO_ISOGENY_UPPER_BOUND", upper;
    print "ISOGENY_SELMER_DIMENSIONS", dims;
    print "DUAL_ISOGENY_SELMER_DIMENSIONS", dual_dims;
    assert upper eq 1;

    // The lower bound is the Nagell--Lutz proof above, the upper bound
    // is algebraic isogeny descent; no high-level RankBounds call is used.
    print "CERTIFIED_ALGEBRAIC_RANK_BOUNDS", 1, upper;
    // CremonaReference is used only for model identity, after rank proof.
    print "CREMONA_REFERENCE_MODEL_ONLY", CremonaReference(E);
    print "CURVE_END", name;
end for;
print "ELLIPTIC_RANK_COMPLETE";
quit;
