// Quadratic-order class numbers for the CM derangement table in Section 5.
// Exact computations in Magma; see README.md for the inputs and scope.
// QuadraticOrder(QuadraticForms(D)) preserves the signed order discriminant.
// PicardNumber is used: ClassNumber(O) is documented for maximal orders.
// Compare independently with an integer-only enumeration of primitive
// reduced positive definite forms [a,b,c], b^2-4ac=D.

SetSeed(20260920);

function ReducedPrimitiveForms(D)
    assert D lt 0 and D mod 4 in {0,1};
    forms := [];
    for a in [1..Isqrt((-D) div 3)] do
        for b in [-a..a] do
            if (b*b-D) mod (4*a) ne 0 then continue; end if;
            c := (b*b-D) div (4*a);
            if a gt c or GCD(GCD(a,b),c) ne 1 then continue; end if;
            if (Abs(b) eq a or a eq c) and b lt 0 then continue; end if;
            Append(~forms, <a,b,c>);
        end for;
    end for;
    return forms;
end function;

function OrderClassNumber(D)
    Q := QuadraticForms(D);
    O := QuadraticOrder(Q);
    assert Discriminant(O) eq D;
    h := PicardNumber(O);
    forms := ReducedPrimitiveForms(D);
    assert h eq #forms;
    printf "ORDER D=%o conductor=%o h=%o reduced_forms=%o\n",
        D, Conductor(O), h, forms;
    return h;
end function;

levels := [37,43,53,61,65,79,83,89,101,131];
expected := [2,1,6,6,8,5,3,12,14,5];
print "TABLE columns: N D_N h(D_N) h(-4N) Fricke_fixed_points";
for k in [1..#levels] do
    N := levels[k];
    D := N mod 4 eq 3 select -N else -4*N;
    h := OrderClassNumber(D);
    assert h eq expected[k];
    if N mod 4 eq 3 then
        h4 := OrderClassNumber(-4*N);
        fixed := h+h4;
    else
        h4 := h;
        fixed := h;
    end if;
    printf "TABLE N=%o D_N=%o h=%o h_minus4N=%o fixed_points=%o\n",
        N,D,h,h4,fixed;
end for;
print "CHECK all_class_numbers true";
print "SCOPE h(D_N) is the derangement table; fixed_points is a separate column.";
quit;
