/**
 * Cover for the Meanwell LRS 350 Series of Power Supplies
 *
 * by Hendrik Busch is licensed under a 
 * 
 * Creative Commons Attribution-ShareAlike 4.0 International License.
 */
 
/* [Cover Settings] */

wallThickness = 1.6;

coverHeight = 65;

coverLength = 110;

additionalScrewOverlap = 7.5;

sideCutoutWidth = 20;
sideCutoutHeight = 25;

additionalHoleForSwitch = true;
holeDiameterForSwitch = 22;

/* [Power Supply] */

powerSupplyWidth = 115;
powerSupplyHeight = 30;
powerSupplyLength = 215;

powerSupplyHoleDiameter = 4.5;
sideToScrewDistance = 32.5;
bottomToScrewDistance = 12.8;

/* [C14 Connector] */

connectorWidth = 49;
connectorHeight = 28.5;
connectorHoleDiameter = 4.5;
connectorHoleSpacing = 40;

/* [hidden] */

part_cover();

// Smoothness of round shapes
$fn = 64;

// double wall thickness
dwt = 2 * wallThickness;

// mounting latch length
mll = sideToScrewDistance + additionalScrewOverlap;

// effective width of the cover
coverWidth = powerSupplyWidth + dwt;

// support configuration
supportThickness = 5;
supportWidth = (coverHeight - powerSupplyHeight - dwt) / 3;
supportAngle = 25;
supportLegLength = supportWidth / tan(supportAngle);

/**
 * Creates the final cover by adding cutouts to the cover body.
 */
module part_cover() {
    difference() {
        sub_body();
        translate([(coverWidth - connectorWidth) * 0.9, 5, 5]) rotate([90, 0, 0]) sub_c14Connector();
        if (additionalHoleForSwitch) {
            translate([coverWidth * 0.2, (coverHeight - powerSupplyHeight - wallThickness)/2, coverLength - mll - wallThickness - 0.1]) cylinder(d = holeDiameterForSwitch, h = dwt);
        }
        translate([-wallThickness + 0.1, coverHeight - bottomToScrewDistance, coverLength - additionalScrewOverlap]) rotate([0, 90, 0]) cylinder(d = 4.2, h = dwt);
        translate([coverWidth - wallThickness - 0.1, coverHeight - bottomToScrewDistance, coverLength - additionalScrewOverlap]) rotate([0, 90, 0]) cylinder(d = 4.2, h = dwt);
        hull() {
            translate([coverWidth - wallThickness - 0.1, coverHeight - sideCutoutWidth/2, sideCutoutHeight - sideCutoutWidth/2]) rotate([0, 90, 0]) cylinder(d = sideCutoutWidth, h = dwt);
            translate([coverWidth - wallThickness - 0.1, coverHeight - 0.1, 0]) cube([dwt, 1, sideCutoutHeight]);
            translate([coverWidth - wallThickness - 0.1, coverHeight - sideCutoutWidth, -0.1]) cube([dwt, sideCutoutWidth, 1]);
        }
    }

}

/**
 * Generates the main body of the cover without any cutouts.
 */
module sub_body() {
    difference() {
        union() {
            cube([coverWidth, coverHeight, coverLength - mll]);
            translate([0, coverHeight - powerSupplyHeight - dwt, coverLength - mll]) cube([coverWidth, powerSupplyHeight + dwt, mll]);
        }
        translate([wallThickness, wallThickness, -0.1]) cube([coverWidth - dwt, coverHeight - wallThickness + 0.1, coverLength - mll - wallThickness + 0.1]);
        translate([wallThickness, coverHeight - powerSupplyHeight - wallThickness, coverLength - mll - dwt]) cube([coverWidth - dwt, powerSupplyHeight + wallThickness + 0.1, mll + dwt + 0.1]);
    }
    cube([coverWidth, coverHeight - powerSupplyHeight, wallThickness]);
    linear_extrude(height = wallThickness) polygon(points = [[0, coverHeight - powerSupplyHeight], [coverWidth/2, coverHeight - powerSupplyHeight], [coverWidth/4, coverHeight], [0, coverHeight]]); 
}

/**
 * Represents the cutout for an IEC-60320 C14 connector with fuse and switch. Use this
 * as a difference with your solid body to produce a cutout.
 */
module sub_c14Connector() {
    rounded = 2;
    translate([0, (connectorHoleSpacing + connectorHoleDiameter)/2 - connectorHeight/2, 0]) {
        translate([rounded, rounded, 0]) linear_extrude(height = 10) offset(r = rounded) square([connectorWidth - rounded*2, connectorHeight - rounded*2]);
        translate([connectorWidth/2, (connectorHoleSpacing - connectorHeight)/-2, 0]) cylinder(d = connectorHoleDiameter, h = 10);
        translate([connectorWidth/2, (connectorHoleSpacing + connectorHeight)/2, 0]) cylinder(d = connectorHoleDiameter, h = 10);
    }
}
