$fn = 32;

hull() {
    translate([0, 0, 0.5])
        cube([20, 20, 1], center = true);
    translate([0, 0, 2])    
        cube([18, 18, 4], center = true);
}
translate([0, 0, -5])
    cylinder(d = 8, h = 5);
