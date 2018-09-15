/**
 * Mounting plate for step down module
 *
 * A mounting frame for an LM2596 5V 3A step down module, e.g.
 * https://www.aliexpress.com/item/a/32810967274.html 
 *
 * Copyright 2018, Hendrik Busch
 * https://github.com/hmbusch
 *
 * Licensed under Creative Commons Attribution Share Alike 4.0.
 * https://creativecommons.org/licenses/by-sa/4.0/
 */

spacingX = 23;
spacingY = 36;
distanceZ = 4;
boardThickness = 2;
holeDiameter = 3.5;
supportDiameter = 6;
addedBaseWidth = supportDiameter/2;
$fn = 128;

module mountingPole(x, y) {
    translate([x, y, 0]) cylinder(d = supportDiameter, h = distanceZ);
    translate([x, y, distanceZ]) cylinder(d = holeDiameter, h = boardThickness);
}

mountingPole(-spacingX/2, 0);
mountingPole(spacingX/2, 0);
mountingPole(0, spacingY);
difference() {
    translate([-spacingX/2 - addedBaseWidth/2, -addedBaseWidth/2, 0]) cube([spacingX + addedBaseWidth, spacingY + addedBaseWidth, 2]);
    translate([-spacingX/2 + 1, 1, -0.1]) cube([spacingX - 2, spacingY -2, 2.2]);
}


