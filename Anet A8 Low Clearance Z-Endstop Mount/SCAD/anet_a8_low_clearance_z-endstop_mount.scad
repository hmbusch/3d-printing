/**
 * LOW CLEARANCE Z-ENDSTOP FOR ANET A8 / Tronxy 802 / Hesine 505
 *
 * I created this custom endstop mount because I switched to an extruder
 * that protruded a lot less down than the original one. Even with the
 * z-axis endstop all the way down, the endstop triggered when the nozzle 
 * was still more than 10 millimeters away from the heat bed.
 * This low clearance endstop mount solves that problem by positioning
 * the endstop flush with the z-motor plate. 
 * The second part of this mount is screwed onto the x-axis motor holder
 * and fitted with a long M3 screw. With this screw, you can fine adjust
 * the final endstop position.
 *
 * This design was inspired by http://www.thingiverse.com/thing:1776429 
 * ('Z Endstop Fine Adjustment Prusa i3 - Anet A8' by Meermeneer).
 *
 * LOW CLEARANCE Z-ENDSTOP FOR ANET A8 / Tronxy 802 / Hesine 505
 * by Hendrik Busch is licensed under a 
 * 
 * Creative Commons Attribution-ShareAlike 4.0 International License.
 */ 

/**
 * With this switch you can control wether the part with the adjustment
 * screw is printed with an overhang that needs support or if the extrusion
 * goes down all the way to the build plate.
 * The first option is a sleeker design (set value to 'true'), the other one
 * is bulkier but easier to print. Your choice ;-)
 */
coolLooking = true;

// DO NOT EDIT ANYTHING BELOW THIS LINE

$fn = 64;

// Call the assembly
print();

/**
 * Arranges all the pieces so that they can be printed directly
 * once converted to STL.
 */
module print() {
    translate([15, -5, 4]) rotate([180, 0, 0]) part_switchMountingBlock();
    part_zAxisLeg();
}

module part_zAxisLeg() {
    difference() {
        sub_zAxisLegBody();
        translate([56 - 0.01, -5, 14]) rotate([0, 90, 0]) cylinder(d = 2.9, h = 10.02);
        for(offset = [5, 35]) {
            translate([offset, 5, -0.01]) sub_slot(width = 3.2, length = 15, height = 8.02);
            translate([offset, 5, 4]) sub_slot(width = 6, length = 15, height = 4.01);
        }
    }
}

/**
 * Generates a slot with rounded edges. Well, actually it generates a 
 * block with rounded edged along z-plane that becomes a slot once you
 * subtract it from another solid object.
 */
module sub_slot(width, length, height) {
    hull() {
        cylinder(d = width, h = height);
        translate([length, 0, 0]) cylinder(d = width, h = height);
    }
}

/**
 * Generates the solid body for the attachment that holds the z-axis adjustment screw.
 */
module sub_zAxisLegBody() {
    hull() { 
        translate([1, 0, 0]) cube([55, 10, 1]);
        translate([1, 1, 0]) cylinder(d = 2, h = 1);
        translate([1, 9, 0]) cylinder(d = 2, h = 1);
        translate([1, 1, 7]) rotate([0, 90, 0]) cylinder(d = 2, h = 55);
        translate([1, 9, 7]) rotate([0, 90, 0]) cylinder(d = 2, h = 55);
        translate([1, 1, 7]) sphere(d = 2);
        translate([1, 9, 7]) sphere(d = 2);
    }
    hull() {
        translate([56, -5, 14]) rotate([0, 90, 0]) cylinder(d = 8, h = 10);
        if (coolLooking) {
            translate([56, -9, 12]) cube([10, 1, 1]);
        } else {
            translate([56, -9, 0]) cube([10, 1, 1]);
        }
        translate([56, 0, 0]) cube([10, 10, 1]);
        translate([56, 9, 7]) rotate([0, 90, 0]) cylinder(d = 2, h = 10);
    }
}

/**
 * The final assembly the switch mount. It consists of 2 legs, 1 mounting block and an
 * additional cutout for protruding frame screws.
 */
module part_switchMountingBlock() {
    difference() {
        union() {
            sub_mountingLeg();
            translate([0, 31, 0]) sub_mountingLeg();
            translate([-5, 0, 0]) sub_mountingBlock();
        }
        hull() {
            translate([8.3, 9, -0.01]) cylinder(d = 6, h= 2.601);
            translate([8.3, 34, -0.01]) cylinder(d = 6, h= 2.601);
        }
    }
}

/**
 * A block onto which the microswitch is supposed to mount. The holes are intended
 * for 1.8 - 2mm self-tapping screws. The measurements are modelled after a Cherry 
 * DB3 microswitch.
 */
module sub_mountingBlock() {
    difference() {
        translate([0, 0, -5]) cube([5, 43, 9]);
        for( offset = [4.875 : 9.5/2 : 42] ) {
            translate([-0.01, offset, -2.15]) rotate([0, 90, 0]) cylinder(d = 1.8, h = 5.02);
        }
    }
}

/**
 * Blueprint for a leg with which to mount the assembly to the existing NEMA
 * motor holes.
 */
module sub_mountingLeg() {
    difference() {
        hull() {
            cube([1, 12, 4]);
            translate([28, 2, 0]) cylinder(r = 2, h = 4);
            translate([28, 10, 0]) cylinder(r = 2, h = 4);
        }
        translate([23.5, 6, 0]) part_screwHole(hole = 3, top = 6, bottomHeight = 1.5, topHeight = 2.5);
    }
}

/**
 * Generates a hole for screws, including screw shaft and head or shaft and nut.
 * This module can be parameterized to produce the necessary bodies.
 */
module part_screwHole(hole = 3, top = 6, bottomHeight = 5, topHeight = 5, forNut = false) {
    translate([0, 0, -0.01]) cylinder(d = hole + 0.2, h = bottomHeight + 0.02);
    if (forNut) {
        upscaleRatio = 1/cos(180/6);
        translate([0, 0, bottomHeight]) cylinder(r = (top*0.99)/2 * upscaleRatio, h = topHeight + 0.01, $fn=6);
    }
    else {
        translate([0, 0, bottomHeight - 0.01]) cylinder(d = top + 0.2, h = topHeight + 0.02);
    }
}