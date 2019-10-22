$fn = 64;
washer_diameter = 7;
washer_height = 1.4;
m3_hole = 3.2;
hole_spacing_front = 30.5;

/* 
 * SHORTCUT VARIABLES
 */

// hole spacing front half 
hsfh = hole_spacing_front / 2;

difference() {
    union() {
        hull() {
            translate([hsfh, 0, 0]) cylinder(d = washer_diameter, h = washer_height);
            translate([hsfh - 4, 2, 0]) cube([4, 4, washer_height]);
        }
        hull() {
            translate([-hsfh, 0, 0]) cylinder(d = washer_diameter, h = washer_height);
            translate([-hsfh, 2, 0]) cube([4, 4, washer_height]);
        }
        translate([-hsfh, 2, 0]) cube([hole_spacing_front, 4, washer_height]);
    }
    // M3 holes
    translate([hsfh, 0, -0.01]) cylinder(d = m3_hole, h = washer_height + 0.02);
    translate([-hsfh, 0, -0.01]) cylinder(d = m3_hole, h = washer_height + 0.02);
}


