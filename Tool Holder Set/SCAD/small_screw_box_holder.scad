$fn = 128;

bottomThickness = 5;
wallThickness = 3;
wallHeight = 15;
boxHeight = 22;
cornerWidth = 25;

module boxHolderCorner() {

    // base
    difference() {
        cube([cornerWidth, boxHeight + wallThickness * 2, bottomThickness]);
        translate([wallThickness, wallThickness, 2.5]) cube([cornerWidth, 10, 3]);
    }

    // front wall
    difference() {
        translate([0, 0, bottomThickness]) cube([cornerWidth, wallThickness, wallHeight]);
        translate([wallThickness + (cornerWidth - wallThickness)/2, wallThickness + 1, bottomThickness + wallHeight/2]) rotate([90, 0, 0]) cylinder(d = 10, h = wallThickness + 2);
    }
    
    // back wall
    difference() {
        translate([0, cornerWidth, bottomThickness]) cube([cornerWidth, wallThickness, wallHeight]);
        translate([wallThickness + (cornerWidth - wallThickness)/2, boxHeight + wallThickness * 2 + 2, bottomThickness + wallHeight/2]) rotate([90, 0, 0]) cylinder(d = 3.2, h = wallThickness + 2);
        translate([wallThickness + (cornerWidth - wallThickness)/2, boxHeight + wallThickness + 2 - 0.01, bottomThickness + wallHeight/2]) rotate([90, 0, 0]) cylinder(d1 = 3.2, d2 = 7, h = 2);
    }
    
    // side wall
    translate([0, 0, bottomThickness]) cube([wallThickness, boxHeight + wallThickness * 2, wallHeight]);
}

boxHolderCorner();
translate([60, 0, 0]) mirror([1, 0, 0]) boxHolderCorner();