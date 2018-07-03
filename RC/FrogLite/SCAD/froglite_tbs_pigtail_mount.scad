$fn = 64;

difference() {
    union() {
        hull() {
            cube([18, 4, 10]);
            translate([1.5, 5.5, 0]) cylinder(d = 3, h = 10);
            translate([16.5, 5.5, 0]) cylinder(d = 3, h = 10);
            translate([0, -4.5, 8]) cube([18, 4, 2]);
        }
        hull() {
            rotate([30, 0, 0]) cube([18, 0.001, 11.6]);
            translate([0, -4.5, 8]) cube([18, 4, 2]);
        }
    }
    translate([9, 3.5, -0.1]) cylinder(d = 5, h = 20);
    translate([3, 3.5, -0.1]) cylinder(d = 2.5, h = 11);
    translate([15, 3.5, -0.1])  cylinder(d = 2.5, h = 11);
    translate([-1, 6.5, 4]) rotate([30, 0, 0]) cube([20, 8, 3]);
    translate([3, 6, 5.5]) rotate([120, 0, 0]) cylinder(d = 3, h = 10);
    translate([15, 6, 5.5]) rotate([120, 0, 0]) cylinder(d = 3, h = 10);
}

