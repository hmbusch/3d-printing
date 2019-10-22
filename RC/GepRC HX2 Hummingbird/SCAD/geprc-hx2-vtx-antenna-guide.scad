$fn = 64;

difference() {
    union() {
        difference() {
            cube([10, 14, 1.2]);
            translate([5, 10, -0.1]) cylinder(d = 2.2, h = 1.4);
        }
        hull() {
            translate([4, 0.6, 0]) rotate([20, 0, 0]) cube([2, 7, 1.2]);
            translate([4, 0, 0]) cube([2, 7.5, 1.2]);
            translate([4, 6.5, 0]) cube([2, 1, 3.6]);
        }
        translate([2.8, 0, 0]) cube([1.2, 7.5, 6]);
        translate([6, 0, 0]) cube([1.2, 7.5, 6]);
    }
    translate([0, 2.2, 3.5]) rotate([20, 0, 0]) cube([10, 2.6, 1.2]);
    translate([0, 3, 1.2]) rotate([20, 0, 0]) cube([10, 2.6, 1.2]);
    translate([0, 5.2, 6]) rotate([-20, 0, 0]) cube([10, 2.6, 1.2]);
    translate([0, 0, 5.2]) rotate([20, 0, 0]) cube([10, 2.6, 1.2]);
}
