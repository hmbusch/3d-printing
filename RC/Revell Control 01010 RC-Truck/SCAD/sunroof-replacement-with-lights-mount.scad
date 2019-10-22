$fn = 64;

sunroofWidth = 36;
sunroofLength = 22;
sunroofHeight = 1.8;
sunroofCurveDiameter = 250;
sunroofCurveOffset = 1.4;

overlap = 2.5;

sunroofOverlapWidth = sunroofWidth + 2 * overlap;
sunroofOverlapLength = sunroofLength + 2 * overlap;
sunroofOverlapHeight = 1;

lightPoleDistance = 18.5;
lightPoleScrewHoleDiameter = 2.5;
lightPoleDiameter = 5.3;
lightPoleInset = 1.5;

lightPoleScrewHoleHeight = 10;
lightPoleMountZOffset = -2;


module raisedSunroof() {
    union() {
        cube([sunroofWidth, sunroofLength, sunroofHeight]);
        difference() {
            translate([sunroofWidth/2, sunroofCurveDiameter/2 - sunroofCurveOffset, 0]) cylinder(d= sunroofCurveDiameter, h = sunroofHeight, $fn = 256);
            translate([-sunroofCurveDiameter/2 + sunroofWidth/2, 0, -0.01]) cube([sunroofCurveDiameter, sunroofCurveDiameter, 2 * sunroofHeight]);
        }
    }
}

difference() {
    union() {
        cube([sunroofOverlapWidth, sunroofOverlapLength, sunroofOverlapHeight]);
        translate([overlap, overlap, sunroofOverlapHeight]) raisedSunroof();
    }
    translate([(sunroofOverlapWidth - lightPoleDistance)/2, sunroofOverlapLength/2, lightPoleMountZOffset]) union() {
        insetZPos = -lightPoleMountZOffset + sunroofHeight + sunroofOverlapHeight - lightPoleInset + 0.01;
        cylinder(d = lightPoleScrewHoleDiameter, h = lightPoleScrewHoleHeight);
        translate([0, 0, insetZPos])cylinder(d = lightPoleDiameter, h = lightPoleInset);
        translate([lightPoleDistance, 0, 0]) cylinder(d = lightPoleScrewHoleDiameter, h = lightPoleScrewHoleHeight);
        translate([lightPoleDistance, 0, insetZPos])cylinder(d = lightPoleDiameter, h = lightPoleInset);
    }
}