# Quadratic-order class numbers

`class_numbers.m` computes the ten class numbers in Section 5. The signed
order discriminant `D` is passed to `QuadraticForms(D)` and then to
`QuadraticOrder`. The script checks that the constructed order has exactly
discriminant `D` and uses `PicardNumber` to retain nonmaximal orders. It
independently enumerates primitive reduced positive definite binary quadratic
forms using integer arithmetic and compares the two answers.

The manuscript's table uses `D_N=-N` if `N=3 mod 4`, and `D_N=-4N`
otherwise. Its column `h(D_N)` tests the derangement criterion; it is not
the number of fixed points of the Fricke involution. The script separately
computes the fixed-point counts `h(-4N)+h(-N)` when `N=3 mod 4`, and
`h(-4N)` otherwise, using the CM correspondence proved in the manuscript.

The installed Magma V2.28 handbook documents the constructor
`QuadraticOrder(Q)` in *Binary quadratic forms: quadratic orders*, and
`PicardNumber(O)` in *Quadratic fields: ideal class group*. The current
official handbook describes [binary quadratic form class groups](https://magma.maths.usyd.edu.au/magma/handbook/text/374)
and [quadratic order Picard groups](https://magma.maths.usyd.edu.au/magma/handbook/text/397).
These documentation pages were checked on 2026-09-20. In particular,
`ClassNumber(O)` is documented for maximal orders and is not used here for
a nonmaximal order.

Run `magma -b class_numbers.m` from this directory. Tested with Magma
V2.28-9 on 2026-09-20, in 0.036 seconds, with exit status 0 and empty
stderr. `class_numbers.out` is the unedited stdout from that execution;
all ten table values agree with the independent reduced-form enumeration.
The extra values are `h(-172)=3`, `h(-316)=5`, `h(-332)=9`, and
`h(-524)=15`. In the order of the manuscript's levels, the Fricke
fixed-point counts are `2,4,6,6,8,10,12,12,14,20`.

The script has SHA-256
`2980442c117a4129e1951898247d4cc117df3a0709772a18081eaaefd78e4502`.
The table in the code is used only as a regression assertion after the
class numbers have been computed.
