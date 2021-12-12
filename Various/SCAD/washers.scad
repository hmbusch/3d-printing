$fn = 64;

difference() {
    union() {
        cylinder(d = 15, h = 1);
        cylinder(d = 10, h = 1.8);
    }
    cylinder(d = 3.6, h = 2);
}