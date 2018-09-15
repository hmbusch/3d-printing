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

difference() {
    cylinder(d=16.5, h = 55);
    translate([0, 0, 1.6]) cylinder(d1 = 4, d2=14.5, h = 5);
    translate([0, 0, 6.59]) cylinder(d = 14.5, h = 50);    
}