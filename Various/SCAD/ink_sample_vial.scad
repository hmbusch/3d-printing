/**
 * Ink sample vial
 *
 * This is a small sample vial for inks, similar to the ones
 * many companies like Goulet Pens ship their ink samples in.
 * It holds ~5ml of ink and is only intended for temporary use
 * as it has no cap.
 *
 * Copyright 2018, Hendrik Busch
 * https://github.com/hmbusch
 *
 * Licensed under Creative Commons Attribution Share Alike 4.0.
 * https://creativecommons.org/licenses/by-sa/4.0/
 */
 
$fn = 128;
fudge = 0.01;

module vial(height = 55) {
    difference() {
        cylinder(d=16.5, h = height);
        translate([0, 0, 1.6]) cylinder(d1 = 4, d2=14.5, h = height * 0.1);
        translate([0, 0, height * 0.1 + 1.6 - fudge]) cylinder(d = 14.5, h = height * 0.9);    
    }
}

vial();
translate([20, 0, 0]) vial(30);