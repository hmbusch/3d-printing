$fn = 64;

translate([0, 2, 0])
    difference() {
        cube([50, 8, 6]);
        translate([50/2, 8/2, 0])
            cylinder(d = 3.6, 6);
        }
cube([50, 2, 8]);