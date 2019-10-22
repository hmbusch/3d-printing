wallThickness = 1.6;

/* hidden */

wt = wallThickness;
dwt = 2*wallThickness;

module holderSnipeNosePliers() {
    difference() {
        cube([24, 16, 36]);
        translate([wt, wt+4, wt]) cube([24-dwt, 12-dwt, 36]);
        translate([(24-15)/2, wt+4, 0]) cube([15, 12-dwt, wt]);
    }
    translate([-10, 0, 18]) screwBlock();
    translate([24, 0, 18]) screwBlock();
}

module holderLargeWirecutters() {
    difference() {
        cube([22, 18, 37]);
        translate([wallThickness, 6, wallThickness]) cube([22-2*wallThickness, 18 - 6 - wallThickness, 37]);
    }
    translate([-10, 0, 18]) screwBlock();
    translate([22, 0, 18]) screwBlock();
}

module screwBlock() {
    $fn = 64;
    difference() {
        cube([10, 10, 10]);
        translate([5, 10, 5]) rotate([90, 0, 0]) cylinder(d=4.2, h=10);
        translate([5, 10, 5]) rotate([90, 0, 0]) cylinder(d=7.5, d2=4, h=3);
    }
    
    
}

translate([0, 0, 0])    holderSnipeNosePliers();
//translate([50, 0, 0])   holderLargeWirecutters();