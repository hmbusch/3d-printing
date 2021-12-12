use <../../Various/SCAD/screw_holes.scad>

$fn = 64;
inch = 25.4;

/**
 * Factor to adjust the miter bar height for a better fit. In an ideal
 * world, this value would always be one, but due to tolerances in 
 * printing and the t-slots, some adjustment may be neccessary for a 
 * good fit.
 */
miter_bar_height_adjustment = 0.95;

// INTERNAL VALUES FROM HERE, DO NOT EDIT
miter_bar_width_1 = inch * 3/4;
miter_bar_width_2 = inch * 15/16;
miter_bar_height_1 = inch * 3/8 * miter_bar_height_adjustment;
miter_bar_height_2 = inch * 1/10;

adjustment_bar_length = 50;
adjustment_bar_height = 10;
adjustment_bar_width = miter_bar_width_1 * 1.5;

module miter_bar(length = 50) {

    union() {
        translate([(miter_bar_width_2 - miter_bar_width_1) / 2, 0, 0])
            cube([miter_bar_width_1, length, miter_bar_height_1]);
        cube([miter_bar_width_2, length, miter_bar_height_2]);
    }
}

module adjustment_bar() {   
    difference() {
        union() {
        translate([-(miter_bar_width_2 - miter_bar_width_1) / 2, 0, -(miter_bar_height_1)])
            miter_bar(length = adjustment_bar_length);
        translate([0, adjustment_bar_length/2, 0])
            cube([miter_bar_width_1, adjustment_bar_length/2, adjustment_bar_height]);
        translate([miter_bar_width_1/4, adjustment_bar_length/2, adjustment_bar_height]) 
            cube([adjustment_bar_width, adjustment_bar_length/2, adjustment_bar_height]);
        }
        translate([0, adjustment_bar_length * 0.75, adjustment_bar_height * 1.5]) {
            rotate([0, 90, 0])
                cylinder(d = 3.1, h = 2 * miter_bar_width_1);
            translate([miter_bar_width_1 * 1.4, 0, 2.5]) 
                cube([2.4, 5.5, 10.5], center = true);
        }
        translate([miter_bar_width_1/2, adjustment_bar_length * 0.25, 15 - miter_bar_height_1])
            rotate([0, 180, 0])
                nut_trap(hole_diameter = 5, size_head = 8, height_shaft = 10, height_trap = 5);        
    }
}

adjustment_bar();
