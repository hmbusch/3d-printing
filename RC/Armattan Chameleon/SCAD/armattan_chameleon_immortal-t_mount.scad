/**
 * Immortal-T Mount for Armattan Chameleon
 *
 * Inspired by https://www.thingiverse.com/thing:2843575 by NA4D
 *
 * I liked the simple mounting solution NA4D came up with, but on 
 * my Chameleon, the antenna was colliding with the printed motor
 * guards and Rotor Riot skids. 
 * So I made a version similar to NA4Ds design but with configurable
 * distance between the antenna and the frame to give me more
 * clearance.
 */

/* [Global] */

// in millimeters
distanceBetweenFrameAndAntenna = 10; // [0:18]

/* [Hidden] */
$fn = 128;

slack = 0.01;

antennaDiaLarge = 5;
antennaDiaMiddle = 4.75;
antennaDiaSmall = 4.5;
clampWidth = 7;
clampThickness = 3.2;

barThickness = 3.2;
barLipThickness = 2.4;
barLipHeight = 3;
barLipOffset = 0;
barLength = distanceBetweenFrameAndAntenna + clampWidth/2 + barLipThickness;

screwHoleDia = 3.1;
screwHoleFrameOffset = 2.5;

module roundAntennaClamp() {
    difference() {
        union() {
            cylinder(d1 = antennaDiaLarge + clampThickness, d2 = antennaDiaMiddle + clampThickness, h = 2);
            translate([0, 0, 2]) cylinder(d = antennaDiaMiddle + clampThickness, h = clampWidth - 3);
            translate([0, 0, clampWidth - 1]) cylinder(d1 = antennaDiaMiddle + clampThickness, d2 = antennaDiaSmall + clampThickness, h = 1);
        }
        // antenna cone cutout
        union() {
            translate([0, 0, -slack]) cylinder(d1 = antennaDiaLarge, d2 = antennaDiaMiddle, h = 2 + 2 * slack);
            translate([0, 0, 2]) cylinder(d = antennaDiaMiddle, h = clampWidth - 3 + 2 * slack);
            translate([0, 0, clampWidth - 1]) cylinder(d1 = antennaDiaMiddle, d2 = antennaDiaSmall, h = 1 + slack);
        }
    }
}

module frameMount() {
    difference() {
        union() {
            cube([clampWidth, barLength, barThickness]);
            translate([clampWidth/2, barLength, 0]) cylinder(d = clampWidth, h = barThickness);
            translate([0, barLength - barLipThickness - screwHoleFrameOffset - screwHoleDia/2, barThickness]) cube([clampWidth, barLipThickness, barLipHeight]);
        }
        translate([clampWidth/2, barLength, -slack]) cylinder(d = screwHoleDia, h = clampWidth + 2 * slack);
    }
}


roundAntennaClamp();
translate([-barThickness/2, antennaDiaLarge/2, clampWidth]) rotate([0, 90, 0]) frameMount();

translate([15, 0, 0]) {
    roundAntennaClamp();
    translate([barThickness/2, antennaDiaLarge/2, clampWidth]) rotate([0, 90, 180]) mirror([0, 1, 0]) frameMount();
}
