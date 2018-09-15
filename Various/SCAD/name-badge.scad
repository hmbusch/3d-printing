
baseplateX = 140;
baseplateY = baseplateX / 2;
baseplateZ = 4;

bevelOffset = 2;
/**
 * Door Name Plate
 *
 * A 'fancy' door name plate I designed for my parents house.
 * It is intended for two color printing (as the preview shows),
 * the raised parts are supposed to be printed in a different
 * color than the base.
 * If you change the text, you may also need to adjust the font
 * size or resize the text entirely (or make the badge larger).
 *
 * Copyright 2018, Hendrik Busch
 * https://github.com/hmbusch
 *
 * Licensed under Creative Commons Attribution Share Alike 4.0.
 * https://creativecommons.org/licenses/by-sa/4.0/
 */
 
bevelWidth = 2;
bevelHeight = 2;

writingHeight = 2;

writing = "Busch";
writingFont = "Trajan Pro:style=Bold";
writingSize = 24;

$fn = 128;

module baseplate2d() {    
    difference() {
        square([50,25],center=true);
        translate([25,12.5,0]) circle(5);
        translate([-25,12.5,0]) circle(5);
        translate([-25,-12.5,0]) circle(5);
        translate([25,-12.5,0]) circle(5);
    }
}

module baseplate3d() {
    
    // create the base plate
    color("Black") linear_extrude(baseplateZ) {
        resize([baseplateX, baseplateY, 1]) baseplate2d();
    }
    
    difference() {
        // create a smaller, raised baseplate on top
        color("Gold") linear_extrude(baseplateZ + bevelHeight) {
            offset(-bevelOffset) resize([baseplateX, baseplateY, 1]) baseplate2d();
        }
        // remove the inner part of that raised baseplate, which leaves us with a nice bevel
        translate([0, 0, baseplateZ + 0.01]) {
            color("Black") linear_extrude(bevelHeight) {
                offset(-bevelOffset - bevelWidth) resize([baseplateX, baseplateY, 1]) baseplate2d();
            }
        }
    }
}

module writing() {
    linear_extrude(writingHeight) {
        text(writing, font = writingFont, halign="center", valign="center", size = writingSize);
    }
}

baseplate3d();
translate([0, 0, baseplateZ]) writing();