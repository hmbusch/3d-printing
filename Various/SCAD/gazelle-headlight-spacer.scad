/**
 * Spacer to mount a headlight to an older Gazelle bicycle.
 *
 * I needed this spacer to mount an AXA Headlight to a Gazelle
 * Primeur bicycle, attached to the joining point of the front
 * fork. The mouting flange of the headlight kept colliding with
 * the protruding part of the lower bowl of the headset, so I 
 * needed some spacing and designed this.
 *
 * Copyright of this design 2021, Hendrik Busch
 * https://github.com/hmbusch
 *
 * Licensed under Creative Commons Attribution 4.0 International (CC BY 4.0)
 * https://creativecommons.org/licenses/by/4.0/
 */
$fn = 32;
fudge = 0.01;

difference() {
    union() {
        translate([0, 4, 0])
            cube([13, 18, 7]);
        translate([(13-6)/2, 22-6, 7])
            cube([6, 4, 0.8]);
    }
    translate([13/2, 22-9, -fudge])
        cylinder(d = 6.2, h = 15);
}