$fn = 64;

spacing = 33;
plateHeight = 2.6;

difference() {
    union() {
        hull() {
            translate([-spacing/2, 0, 0]) cylinder(d = 6, h = plateHeight);
            translate([spacing/2, 0, 0]) cylinder(d = 6, h = plateHeight);
            translate([-spacing/3, 4, 0]) cylinder(d = 6, h = plateHeight);
            translate([spacing/3, 4, 0]) cylinder(d = 6, h = plateHeight);        
        }
        translate([0, 1, 0]) hull() {
            translate([-10, 9, 5.5]) rotate([0, 90, 0]) cylinder(d = 6, h = 20);
            translate([-10, 4, 10.5]) rotate([0, 90, 0]) cylinder(d = 3, h = 20);
            translate([-10, -3, 0]) cube([20, 12, plateHeight]);
        }
    }
    translate([-spacing/2, 0, -0.1]) cylinder(d = 2.6, h = plateHeight + 0.2);
    translate([spacing/2, 0, -0.1]) cylinder(d = 2.6, h = plateHeight + 0.2);
    translate([-2.5, 0, 0]) rotate([-32, 0, 0]) cube([5, 12, 15]);    
    translate([6, 3, -1]) rotate([-32, 0, 0]) cylinder(d = 2.5, h = 15);
    translate([-6, 3, -1]) rotate([-32, 0, 0]) cylinder(d = 2.5, h = 15);
}
%translate([0, 4.5, 0]) cylinder(d = 6, h = 20);
%translate([0, 4, 0]) rotate([-32, 0, 0]) cylinder(d = 6, h = 20);

