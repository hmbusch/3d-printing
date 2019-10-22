$fn = 64;

union() {
    difference() {
        union() {
            translate([0, -3, 2.25]) cube([32 + 2.4, 23 + 2.4, 4.5], center = true);
            translate([0, 11.6, 0.5]) cube([32 + 2.4, 4, 1], center = true);
        }
        translate([0, -3, 2.25 + 1.5]) cube([32, 23, 1.51], center = true);
        translate([-10, -3, 2.25 + 1]) cube([8, 26, 4.5], center = true);
        translate([8, -3, 2.25 + 1]) cube([13, 26, 4.5], center = true);
        translate([16, -3, 2.25 + 1]) cube([6, 10, 4.5], center = true);
        translate([10, 10, -0.01]) cylinder(d = 2.3, h = 5);
        translate([-10, 10, -0.01]) cylinder(d = 2.3, h = 5);
        translate([10, -10, -0.01]) cylinder(d = 2.3, h = 5);
        translate([-10, -10, -0.01]) cylinder(d = 2.3, h = 5);
        translate([-2.25, -3, 1 + 1.6/2]) cube([4, 23 + 2.4 + 0.02, 1.6], center = true);
    }
    translate([6, -11.7, 1.5]) cube([1.2, 8, 3], center = true);
    translate([6, 5.7, 1.5]) cube([1.2, 8, 3], center = true);
}
