/**    
 * Customizable Spool Holder with Bearings 
 * by Hendrik Busch is licensed under a 
 * 
 * Creative Commons Attribution-ShareAlike 4.0 International License.
 *
 * YOU NEED TO PRINT TWO SETS OF THESE FOR A FULL SPOOL HOLDER!
 *
 * All units are in millimeters. You will need two bearings per cone
 * to ensure that only the bearings rest on the rod.
 *
 * https://github.com/hmbusch/3d-printing
 */
 
/**
 * Defines how smooth any round surfaces are. The higher you set this
 * value, the longer rendering and slicing takes. 64 is usually a good
 * default value.
 */
$fn = 64;

/**
 * Defines the total height of the spool holder cone, including
 * the washers.
 * 
 * default: 30
 */
coneHeight = 30;

/**
 * This value controls how big the outer side of the cone will be.
 * It should be set to the largest spool hole diameter you need to
 * work with plus an additional 5mm for better mounting.
 */
coneWidthBottom = 60;

/**
 * This value controls how big the inner side of the cone will be
 * It should be set to the smallest spool hole diameter you need to
 * work with minus an additional 5mm for better mounting.
 *
 * default: 35
 */
coneWidthTop = 35;

/**
 * The diameter of the rod that will hold the spool. This has to
 * conform to the inner diameter of the bearing you will use.
 *
 * default: 8 (for 608ZZ bearings)
 */
rodDiameter = 8;

/**
 * The outer diameter of your bearings. The design includes an
 * additional 0.1mm clearance for easier insertion of the bearing,
 * you don't need to add additional clearance here.
 *
 * default: 22 (for 608ZZ bearings)
 */
bearingDiameter = 22;

/**
 * The height of your bearings. The design includes an
 * additional 0.1mm clearance to reduce the bindung of the bearing,
 * you don't need to add additional clearance here.
 *
 * default: 7 (for 608ZZ)
 */
bearingHeight = 7;

/**
 * How deep will the screw holes be on the center part of the cone?
 * I designed this for 3x12mm self-tapping screws.
 * 
 * default: 12
 */
bodyScrewHoleDepth = 12;

/**
 * The diameter of the screw holes that the washer screws screw into.
 * I designed this for 3x12mm self-tapping screws.
 *
 * default: 2.5
 */ 
bodyScrewHoleDiameter = 2.5;

/**
 * The diameter of the countersunk screw head.
 *
 * default: 6
 */
washerScrewHeadSize = 6;

/**
 * How large should the screw holes in the washers be?
 *
 * default: 3
 */
washerScrewDiameter = 3;

/**
 * The height of each washers. This directly affects the size of the
 * center cone, which will be coneHeight - 2 * washerHeight in height.
 *
 * default: 3
 */
washerHeight = 3;

// CALCULATE SOME ADDITIONAL DEPENDENT VARIABLES
centerOffset = bearingDiameter/2 + (coneWidthTop - bearingDiameter)/4;
rodClearanceDiameter = max(rodDiameter * 1.5, rodDiameter + 4);
effectiveConeHeight = coneHeight - 2 * washerHeight;

// uncomment this if you want to generate STL for printing
print();

// comment print() and uncomment this to so the assembled version of the cone.
//assembly();

/**
 * Lays the parts out for 3D printing.
 */
module print() {
    part_spoolCone();
    translate([coneWidthBottom / 2 + coneWidthTop/2 + 2, coneWidthTop / 2 + 1, 0]) part_topWasher();
    translate([coneWidthBottom * 0.8 + 2, -(coneWidthBottom / 2 + 2), 0]) part_bottomWasher();
    translate([0, -coneWidthBottom * 0.75, 0]) part_bearingClampingSleeve();
}

/**
 * Creates an assembled view of the parts.
 */
module assembly() {
    part_spoolCone();
    translate([0, 0, -washerHeight]) part_bottomWasher();
    translate([0, 0, effectiveConeHeight + washerHeight]) rotate([0, 180, 0]) part_topWasher();
    translate([0, 0, -6.5]) part_bearingClampingSleeve();
}

/**
 * Creates the top washer.
 */
module part_topWasher() {
    difference() {
        // get the top slice of the cone and refill the bearing cutout
        union() {
            translate([0, 0, washerHeight]) rotate([0, 180, 0]) sub_cone(begin = coneHeight - washerHeight);
            cylinder(d = bearingDiameter + 0.1, h = washerHeight);
        }
        
        // Give the bearing clearance to that only the outer rim is clamped to the cone
        translate([0, 0, washerHeight - 1]) cylinder(h = 1.01, d = bearingDiameter - 2);
        
        // Add countersunk screw holes
        sub_sunkenWasherScrewHoles();
        
        // Hole for the rod with ample clearance
        translate([0, 0, -0.01]) cylinder(h = washerHeight + 0.02, d = rodClearanceDiameter);
    }
}

/**
 * Creates the bottom washer.
 */
module part_bottomWasher() {
    difference() {
        // get the bottom slice of the cone and refill the bearing cutout
        union() {
            sub_cone(end = washerHeight);
            cylinder(d = bearingDiameter + 0.1, h = washerHeight);
        }
        
        // Give the bearing clearance to that only the outer rim is clamped to the cone
        translate([0, 0, washerHeight - 1]) cylinder(h = 1.01, d = bearingDiameter - 2);
        
        // Add countersunk screw holes
        sub_sunkenWasherScrewHoles(offset = centerOffset * 1.3);
        
        // Hole for the rod with ample clearance
        translate([0, 0, -0.01]) cylinder(h = washerHeight + 0.02, d = rodClearanceDiameter);
    }
}

/**
 * This module creates the center part of the cone with screw holes on top
 * and bottom.
 */
module part_spoolCone() {
    endHeight = coneHeight - washerHeight;
    difference() {
        sub_cone(begin = washerHeight, end = endHeight);
        for (angle = [0 : 90 : 360]) {
            rotate([0, 0, angle]) translate([centerOffset, 0, effectiveConeHeight - bodyScrewHoleDepth]) cylinder(d=bodyScrewHoleDiameter, h = bodyScrewHoleDepth + 0.01);
            rotate([0, 0, angle]) translate([centerOffset * 1.3, 0, -0.01]) cylinder(d = bodyScrewHoleDiameter, h = bodyScrewHoleDepth + 0.01);
        }
    }
}

/**
 * This module constructs the basic cone. Begin and end offset can be defined, so that
 * this module can also generate slices of the cone for the top and bottom washers. Slices
 * will always be translated to 0,0,0 so they are easier to work with.
 *
 * @parameter begin
 *                the cone begins at this height, default 0
 * @parameter end
 *                the cone ends at this height, default is coneHeight
 */
module sub_cone(begin = 0, end = coneHeight) {    
    endOffset = coneHeight - end;        
    difference() {
        translate([0, 0, -begin]) {
            difference() {
                // base cone
                cylinder(h = coneHeight, d1 = coneWidthBottom, d2 = coneWidthTop);
                
                // hole for rod (with ample clearance)
                translate([0, 0, -0.01]) cylinder(h = coneHeight + 0.02, d = rodDiameter * 1.6);
                
                // bottom cutout for bearing
                translate([0, 0, begin - 0.01]) cylinder(h = bearingHeight + 0.51, d = bearingDiameter + 0.1);
                
                // support ring for bottom bearing
                translate([0, 0, begin - 0.01]) cylinder(h = bearingHeight + 1.01, d = bearingDiameter - 2 );
                
                // top cutout for bearing
                translate([0, 0, coneHeight - bearingHeight - endOffset - 0.1 ]) cylinder(h = bearingHeight + 0.11, d = bearingDiameter + 0.1);
                
                // support ring for top bearing
                translate([0, 0, coneHeight - bearingHeight - endOffset - 0.5 ]) cylinder(h = bearingHeight + 0.11, d = bearingDiameter - 2);
                
                // remove part of the bottom if requested
                if (begin > 0) {
                    translate([0, 0, begin/2 - 0.01]) cube([coneWidthBottom, coneWidthBottom, begin + 0.01], center = true);
                }
                
                // remove part of the top if requested
                if (end < coneHeight) {
                    translate([0, 0, end + 50]) cube([coneWidthBottom, coneWidthBottom, 100], center = true);
                }            
            }
        }
        
        // Do additional round cutouts to achieve 'star' shape. This needs to be done here to achieve
        // full cutouts.
        for (angle = [0 : 90 : 360]) {
            rotate([0, 0, angle + 45]) translate([coneWidthBottom * 0.55, 0, -0.1 - begin]) cylinder(d = coneWidthBottom * 0.5, h = coneHeight);
        }
    }
}

/**
 * Creates a sleeve that is used to ensure that only the inner ring of
 * the bearing is clamped down when using nuts on the rod and the cone
 * can rotate freely.
 */
module part_bearingClampingSleeve() {
    difference() {
        union() {
            cylinder(d = rodClearanceDiameter + 4, h = 2);
            cylinder(d = rodClearanceDiameter - 0.5, h = 6);
        }
        translate([0, 0, -0.01]) cylinder(d = rodDiameter + 0.5, h = 6.02); 
    }
}

/**
 * Sub-routine to create countersunk screw holes. Note that this module actually creates positives
 * (meaning screw heads), you will need to subtract these from whatever you want to have screw holes.
 */
module sub_sunkenWasherScrewHoles(offset = centerOffset) {
    for (angle = [0 : 90 : 360]) {
        rotate([0, 0, angle]) translate([offset, 0, 0]) cylinder(d = washerScrewDiameter, h = washerHeight + 0.01);
        rotate([0, 0, angle]) translate([offset, 0, 0.5]) cylinder(d2 = washerScrewDiameter, d1 = washerScrewHeadSize + 0.1, h = washerScrewDiameter * 0.7);
        rotate([0, 0, angle]) translate([offset, 0, -0.01]) cylinder(d = washerScrewHeadSize + 0.1, h = 0.52);
    }
}
