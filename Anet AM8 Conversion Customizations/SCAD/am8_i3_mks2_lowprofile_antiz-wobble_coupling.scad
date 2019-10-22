/**
 * Low Profile Anti-Z-Wobble Coupling for AM8 Variant
 *
 * by Hendrik Busch, 2017 (https://github.com/hmbusch)
 *
 * My AM8 variant uses a modfied version of the Prusa i3 MK2S
 * x-carriage, that is not directly coupled to the leadscrews.
 * Instead, the x-carriage rests on these blocks and those
 * those blocks are attached to the lead screws.
 * If the leadscrews wobble, these blocks can slide around under
 * the x-carriage and their movement does not affect the carriage.
 * 
 * The pieces are only as high as the leadscrew nuts themselves
 * so they wouldn't waste any more z-height than neccessary.
 * 
 * The nuts are supposed to be mounted using 4x M3x12 bolts and
 * corresponding M3 nuts per block. 
 */
use <rounded_box.scad>

block_height = 10;

// Leadscrew nut dimensions
nut_outer_diameter = 10.6;
nut_mounting_hole_distance = 16;
nut_mounting_hole_offset = (nut_outer_diameter / 2) + ((nut_mounting_hole_distance - nut_outer_diameter) / 2);

$fn = 128;

module nut_trap(height = 3, diameter = 6) {
    upscaleRatio = 1/cos(180/6);
    cylinder(r = (diameter * 0.97)/2 * upscaleRatio, h = height, $fn=6);
}

module z_coupling() {
    difference() { 
        box_with_round_edges(width = 43, depth = 35, height = block_height);
        translate([23/2 + 1, 25/2, 0]) {
            cylinder(d = nut_outer_diameter, h = block_height);
            for(angle = [0, 90, 180, 270]) {
                rotate([0, 0, angle]) translate([nut_mounting_hole_offset, 0, 0]) cylinder(d = 3.2, h = block_height);
                rotate([0, 0, angle]) translate([nut_mounting_hole_offset, 0, block_height - 3.8]) rotate([0, 0, 30, 0]) nut_trap(height = 3.8);
            }
        }
        translate([23/2 + 2 + 21, 25/2, 0]) {
            cylinder(d = 10, h = block_height);
        }
        
    }    
}

translate([-43/2, 5, 0]) z_coupling();
translate([-43/2, -5, 0]) mirror([0, 1, 0]) z_coupling();