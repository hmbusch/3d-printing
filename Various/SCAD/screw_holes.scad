/**
 * Generates a hole for screws, including screw shaft and head or shaft and nut.
 * This module can be parameterized to produce the necessary bodies.
 */
module screw_trap(hole = 3, top = 6, bottomHeight = 5, topHeight = 5, forNut = false) {
    translate([0, 0, -0.01]) cylinder(d = hole + 0.2, h = bottomHeight + 0.02);
    if (forNut) {
        upscaleRatio = 1/cos(180/6);
        translate([0, 0, bottomHeight]) cylinder(r = (top*0.99)/2 * upscaleRatio, h = topHeight, $fn=6);
    }
    else {
        translate([0, 0, bottomHeight]) cylinder(d = top + 0.2, h = topHeight);
    }
}

module nut_trap(hole_diameter = 3, size_head = 6, height_shaft = 5, height_trap = 5) {
    screw_trap(hole_diameter, size_head, height_shaft, height_trap, true);
}