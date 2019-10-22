/**
 * The angled wall is using a 45 degree overhang, making all 
 * the triangles needed for offset calculation etc. not only right
 * but also isosceles, which is easier to handle. It also happens 
 * to be the maximum most printers can print as an overhang without
 * supports.
 */
 
/* [Cover] */

wallThickness = 1.6;

coverStraightWidth = 15;
coverAngledWidth = 50;
coverWidth = coverStraightWidth + coverAngledWidth;

coverUpperHeight = 40;
coverLowerHeight = 70;
coverHeight = coverUpperHeight + coverLowerHeight;

/* [Cable Cutouts] */
sideCutoutWidth = 20;
sideCutoutHeight = 25;

bottomCutoutWidth = 30;
bottomCutoutStraightHeight = 50;
bottomCutoutAngledHeight = 30;
bottomCutoutHeight = bottomCutoutStraightHeight + bottomCutoutAngledHeight;

/* [C14 Connector] */

connectorWidth = 49;
connectorHeight = 28.5;
connectorHoleDiameter = 4.5;
connectorHoleSpacing = 40;
connectorExtrusionHeight = 3 * wallThickness;

/* [Power Supply] */
powerSupplyDepth = 115;
powerSupplyWidth = 30;
powerSupplyOverlapHeight = 40;

powerSupplyHoleDiameter = 4.5;
sideToScrewDistance = 32.5;
bottomToScrewDistance = 12.8;

/* [hidden] */

$fn = 64;

// To ensure a correct thickness of the angled wall, we need
// to offset the inner point a little bit. Math for the win!
innerAngleOffset = wallThickness - sqrt(2 * pow(wallThickness, 2));

// Points for the outer polygon
op1 = [0, 0];
op2 = [coverWidth, 0];
op3 = [coverWidth, coverHeight];
op4 = [coverAngledWidth, coverHeight];
op5 = [0, coverHeight - coverAngledWidth];

// Point for the inner polygon
ip1 = op1 + [wallThickness, wallThickness];
ip2 = op2 + [0.01, wallThickness];
ip3 = op3 - [-0.01, wallThickness];
ip4 = op4 - [innerAngleOffset, wallThickness];
ip5 = op5 + [wallThickness, innerAngleOffset];

// Points for the bottom cutout
bcp1 = [0, 0];
bcp2 = [bottomCutoutWidth, 0];
bcp3 = [bottomCutoutWidth, bottomCutoutHeight];
bcp4 = [0, bottomCutoutStraightHeight];

completedCover();

module completedCover() {
    difference() {
        part_3d_coverBody();
        
        // power supply cutout
        translate([coverWidth - powerSupplyWidth, 
                   coverHeight - powerSupplyOverlapHeight, 
                   wallThickness]) part_3d_powerSupplyDummy();
        
        // C14 connector cutout
        translate([-wallThickness, 
                   (coverHeight - coverAngledWidth) * 0.05, 
                    wallThickness + powerSupplyDepth * 0.95]) rotate([0, 90, 0]) sub_3d_c14Connector();
        
        // side cutout
        translate([coverWidth - sideCutoutWidth + 0.01, 0, wallThickness + powerSupplyDepth - 0.01]) sub_3d_sideCutout();
        
        // bottom cutout
        translate([coverWidth - bottomCutoutWidth + 0.02, 0, wallThickness + powerSupplyDepth]) rotate([270, 0, 0]) sub_3d_bottomCutout();

        // screw holes
        translate([coverWidth - bottomToScrewDistance, coverHeight - (coverUpperHeight - sideToScrewDistance), 0]) /*rotate([0, 90, 0])*/ cylinder(d = powerSupplyHoleDiameter, h = 3 * wallThickness);
        translate([coverWidth - bottomToScrewDistance, coverHeight - (coverUpperHeight - sideToScrewDistance), powerSupplyDepth]) /*rotate([0, 90, 0])*/ cylinder(d = powerSupplyHoleDiameter, h = 3 * wallThickness);
        
        // hole for LED
        translate([-10, coverLowerHeight + 9, wallThickness + 7.5]) rotate([0, 90, 0]) cylinder(d = 3, h = 100);
    }
}

/**
 * Assembles the cover body from two endplates and the main extrusion
 * inbetween. Cutouts for the connector and the power supply are added
 * in another module.
 */
module part_3d_coverBody() {
    sub_3d_endPlate();
    translate([0, 0, wallThickness]) sub_3d_mainExtrusion();
    translate([0, 0, wallThickness + powerSupplyDepth]) sub_3d_endPlate(); 
}

/**
 * Represents the lower part of the power supply that protrudes into the cover.
 * Used to create the neccessary cutout for the power supply.
 */
module part_3d_powerSupplyDummy() {
    cube([powerSupplyWidth + 0.01, powerSupplyOverlapHeight + 0.01, powerSupplyDepth]);
}

/**
 * The part that will be removed on the lower right hand side of the cover.
 */
module sub_3d_sideCutout() {
    hull() {
        translate([sideCutoutWidth / 2, sideCutoutHeight - sideCutoutWidth / 2, 0]) cylinder(d = sideCutoutWidth, h = 2 * wallThickness);
        translate([sideCutoutWidth - 1, 0, 0]) cube([1, sideCutoutHeight, 2 * wallThickness]);
        cube([sideCutoutWidth, 1, 2 * wallThickness]);
    }
}

/**
 * This is the extrusion of the outline of the cover. End plates are added
 * in another module, this is just the main profile.
 */
module sub_3d_mainExtrusion() {
    linear_extrude(height = powerSupplyDepth) sub_2d_outline();
}

/**
 * An extrusion of the outer polygon with a height equal to the wall thickness.
 */
module sub_3d_endPlate() {
    linear_extrude(height = wallThickness) sub_2d_outerPolygon();
}

/**
 * By subtracting the inner polygon from the outer one, this generates
 * the general lines required for the walls of the cover, which will 
 * then be extruded.
 */
module sub_2d_outline() {
    difference() {
        sub_2d_outerPolygon();
        sub_2d_innerPolygon();
    }
}

/**
 * Generates the outer polygon shape of the cover.
 */
module sub_2d_outerPolygon() {
    polygon(points = [op1, op2, op3, op4, op5]);
}

module sub_3d_bottomCutout() {
    linear_extrude(height = wallThickness + 0.02) sub_2d_bottomCutoutShape();
}


module sub_2d_bottomCutoutShape() {
    polygon(points = [bcp1, bcp2, bcp3, bcp4]);
}

/**
 * Generates the inner polygon shape of the cover. This has the same shape
 * as the outer polygon but is set inward by the wall thickness requested, except
 * on the right side (back side, this will face the power supply, hence there
 * is no wall there.
 */
module sub_2d_innerPolygon() {
    polygon(points = [ip1, ip2, ip3, ip4, ip5]);
}

/**
 * Represents the cutout for an IEC-60320 C14 connector with fuse and switch. Use this
 * as a difference with your solid body to produce a cutout.
 */
module sub_3d_c14Connector() {
    rounded = 2;
    translate([0, (connectorHoleSpacing + connectorHoleDiameter)/2 - connectorHeight/2, 0]) {
        translate([rounded, rounded, 0]) linear_extrude(height = connectorExtrusionHeight) offset(r = rounded) square([connectorWidth - rounded*2, connectorHeight - rounded*2]);
        translate([connectorWidth/2, (connectorHoleSpacing - connectorHeight)/-2, 0]) cylinder(d = connectorHoleDiameter, h = connectorExtrusionHeight);
        translate([connectorWidth/2, (connectorHoleSpacing + connectorHeight)/2, 0]) cylinder(d = connectorHoleDiameter, h = connectorExtrusionHeight);
    }
}
