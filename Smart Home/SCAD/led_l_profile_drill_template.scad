$fn=64;
fudge = 0.1;

// Derived values, do not edit
nf = -fudge;
pf = fudge;
dpf = 2 * fudge;

difference() {
    cube([120, 8, 5]);
    translate([nf, nf, 1]) cube([100 + pf, 8 + dpf, 4 + pf]);
    translate([110, 4, nf]) cylinder(d = 3.9, h = 5 + dpf);
    translate([10, 4, nf]) cylinder(d = 2, h = 5 + dpf);
}