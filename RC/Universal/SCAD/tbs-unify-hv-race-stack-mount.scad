$fn = 64;

baseHeight = 2;

module basePlate() {
    difference() {
        union() {
            // mounting posts
            hull() {
                translate([0, 0, 0]) cylinder(d = 6, h = baseHeight);
                translate([1, 1, 0]) cube([6, 6, baseHeight]);

            }
            hull() {
                translate([30.5, 0, 0]) cylinder(d = 6, h = baseHeight);
                translate([23, 1, 0]) cube([6, 6, baseHeight]);
            }
            
            hull() {
                translate([0, 30.5, 0]) cylinder(d = 6, h = baseHeight);
                translate([1, 23, 0]) cube([6, 6, baseHeight]);
            }
            
            hull() {
                translate([30.5, 30.5, 0]) cylinder(d = 6, h = baseHeight);
                translate([23, 23, 0]) cube([6, 6, baseHeight]);
            }
            
            // base plate
            translate([1, 1, 0]) cube([28, 28, baseHeight]);
        }
        translate([0, 0, -0.1]) cylinder(d = 3.2, h = baseHeight + 0.2);
        translate([30.5, 0, -0.1]) cylinder(d = 3.2, h = baseHeight + 0.2);
        translate([0, 30.5, -0.1]) cylinder(d = 3.2, h = baseHeight + 0.2);
        translate([30.5, 30.5, -0.1]) cylinder(d = 3.2, h = baseHeight + 0.2);
    }
}

basePlate();
