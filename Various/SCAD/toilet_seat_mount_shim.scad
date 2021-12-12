$fn = 64;

difference() {
    cylinder(d = 35, h = 4);
    cylinder(d = 23, h = 4);
    translate([0, 0, 4 - 2.8])
        cylinder(d = 32, h = 2.8);
}