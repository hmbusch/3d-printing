
/**
 * The diameter of the hole on the Anet A8 frame. Defaults to 25mm.
 */
frameHoleDiameter = 25;

/**
 * We leave at least 1/2 of the circle plus this value open to still
 * be able to pass cables through. The default offset is 4mm, leaving
 * only about 8.5mm of the hole covered.
 */
frameHoleOffset = 4;

/**
 * The thickness of the frame, the Anet A8 frame is 8mm thick.
 */
frameThickness = 8;

/**
 * The diameter of the tube that this mount is intended for. Defaults
 * to 16mm.
 */
tubeDiameter = 16;

/**
 * The distance from the 'end' of the hole in the frame to the outside 
 * edge of the frame. My Anet A8 frame measured 11.5mm here.
 */
frameHoleToOutsideDistance = 10.5;

/** 
 * Width of the small ridge inside the channel for the tube. This is 
 * supposed to prevent the tube from slipping out of the mount under stress.
 */
ridgeWidth = 0.8;

/**
 * The number of facets in a cylinder. A value of 64 is a good tradeoff 
 * between smoothness of the cylinders and rendering time. 
 */
$fn=64;

/* [hidden] */

// DO NOT EDIT ANYTHING BELOW THIS LINE!

circleSegmentHeight = frameHoleDiameter/2 - frameHoleOffset;
baseWidth = chordLength(frameHoleDiameter/2, frameHoleOffset);
tubeMountWidth = tubeDiameter + 6;
halfTubeMountWidth = tubeMountWidth/2;

translate([0, 0, baseWidth/2]) {
    rotate([0, 90, 0]) rightPart();
    translate([15, 0, 0]) rotate([0, 90, 0]) leftPart();
}

module leftPart() {
    difference() {
        sub_baseMountBody();

        // screw hole 1
        translate([0, circleSegmentHeight/2, 0]) part_screwHole(hole = 3, top = 6, bottomHeight = frameThickness/2, topHeight = tubeDiameter/2);
        
        // screw hole 2
        translate([0, circleSegmentHeight + frameHoleToOutsideDistance + tubeMountWidth + 4, 0])  part_screwHole(hole = 3, top = 6, bottomHeight = frameThickness/2, topHeight = tubeDiameter/2);
    }
}

module rightPart() {
    difference() {
        sub_baseMountBody();
        
        // screw hole 1
        translate([0, circleSegmentHeight/2, 0]) part_screwHole(hole = 3, top = 5.5, bottomHeight = frameThickness/2, topHeight = tubeDiameter/2, forNut = true);
        
        // screw hole 2
        translate([0, circleSegmentHeight + frameHoleToOutsideDistance + tubeMountWidth + 4, 0])  part_screwHole(hole = 3, top = 6, bottomHeight = frameThickness/2, topHeight = tubeDiameter/2, forNut = true);
    }
}

/**
 * This is the base body for one half of the mount. It is modelled in a way to that two copies
 * are absolutely symmetrically to each other.
 */
module sub_baseMountBody() {
    union() {
        translate([0, 0, 0.5]) sub_frameHolePlug(height = frameThickness/2 - 0.5);
    
        hull() {
            translate([0, 0, frameThickness/2]) sub_frameHolePlug();
            translate([-baseWidth/2, circleSegmentHeight + frameHoleToOutsideDistance, frameThickness/2]) cube([baseWidth, 1, halfTubeMountWidth - frameThickness/2]);
        }
        
        difference() {
            hull() {
                translate([-baseWidth/2, circleSegmentHeight + frameHoleToOutsideDistance, 0]) cube([baseWidth, tubeDiameter + 6, halfTubeMountWidth]);
                translate([-5, circleSegmentHeight + frameHoleToOutsideDistance + tubeMountWidth, 0]) cube([10, 8, 5]);
            }
            translate([-baseWidth/2 - 0.01, circleSegmentHeight + frameHoleToOutsideDistance + halfTubeMountWidth, 0]) rotate([0, 90, 0]) cylinder(d=tubeDiameter,h=baseWidth + 0.02);
        }
        
        // Ridge for tube
        difference() {
            translate([-ridgeWidth/2, circleSegmentHeight + frameHoleToOutsideDistance + halfTubeMountWidth, 0]) rotate([0, 90, 0]) cylinder(d = tubeDiameter, h = ridgeWidth);
            translate([-ridgeWidth/2 - 0.01, circleSegmentHeight + frameHoleToOutsideDistance + halfTubeMountWidth, 0]) rotate([0, 90, 0]) cylinder(d = tubeDiameter - 1, h = ridgeWidth + 0.02);
            translate([-ridgeWidth/2 - 0.01, circleSegmentHeight + frameHoleToOutsideDistance + halfTubeMountWidth - tubeDiameter/2, -tubeDiameter/2 - 0.01]) cube([ridgeWidth + 0.02, tubeDiameter, tubeDiameter/2]);
        } 
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
        translate([0, 0, bottomHeight]) cylinder(r = (top*0.99)/2 * upscaleRatio, h = topHeight, $fn=6);
    }
    else {
        translate([0, 0, bottomHeight]) cylinder(d = top + 0.2, h = topHeight);
    }
}

/**
 * The plug intended to fit into the hole on the frame. It covers the half of the frame
 * thickness and covers half of the hole minus the defined offset.
 */
module sub_frameHolePlug(height = frameThickness/2) {
    rotate([0, 0, 180]) translate([0, frameHoleOffset, 0]) difference() {
        cylinder(d=frameHoleDiameter, h = height);
        translate([-frameHoleDiameter/2, -frameHoleOffset, -0.01]) cube([frameHoleDiameter, frameHoleDiameter/2 + frameHoleOffset, height + 0.02]);
    }
}

/**
 * Computes the length of a chord on a circle by using the radius of the circle and the offset 
 * of the chord from the center point of the circle.
 */
function chordLength (radius, triangleHeight) = 2* sqrt(pow(radius, 2) - pow(triangleHeight, 2)); 