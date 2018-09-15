/**
 * Case for Proxxon KT-70
 *
 * I made this 'case' for the Proxxon KT-70 compound table.
 * Mine is sitting on a shelf for most of the time and is 
 * gathering dust. In addition, I couldn't stack anything on
 * top, so it took up more space than I wanted.
 * This case fits my Prusa i3 MK2 build plate (barely) and
 * protects the KT-70 from dust and allows me to stack things
 * on top.
 *
 * Copyright 2018, Hendrik Busch
 * https://github.com/hmbusch
 *
 * Licensed under Creative Commons Attribution Share Alike 4.0.
 * https://creativecommons.org/licenses/by-sa/4.0/
 */
 
wallThickness = 1.2;
innerWidth = 230;
innerLength = 200;
innerHeight = 82;

union() {
    difference() {
        // outer cube
        cube([innerWidth + wallThickness * 2, innerLength + wallThickness * 2, innerHeight + wallThickness]);
        // inner cube
        translate([wallThickness, wallThickness, -0.1]) cube([innerWidth, innerLength, innerHeight + 0.1]);
        
        // cutout for side handle
        union() {
            translate([innerWidth + wallThickness -0.01, innerLength/2 + wallThickness, 24]) rotate([0, 90, 0]) cylinder(d = 21, h = wallThickness * 2);
            translate([innerWidth + wallThickness -0.01, innerLength/2 + wallThickness - 21/2, -0.1]) cube([wallThickness * 2, 21, 24]);
        }
    }
    // load support
    translate([25, (innerLength - 100) / 2, innerHeight - 36]) cube([20, 100, 36]);
    translate([innerWidth + wallThickness - 35, (innerLength - 100) / 2, innerHeight - 36]) cube([20, 100, 36]);

}