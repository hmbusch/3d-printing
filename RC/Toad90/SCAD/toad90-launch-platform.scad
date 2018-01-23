/**
 * Launch Platform for Toad90 Quads (and probably others)
 *
 * by Hendrik Busch, 2018 (https://github.com/hmbusch)
 *
 * A simple, not-angled launching platform to put the Toad90 
 * onto when starting. This provides an even base for the quad
 * when it has a battery mounted below.
 */
$fn = 128;

union() {
    difference() {
        union() {
            cylinder(d = 130, h = 5);
            cylinder(d = 100, h = 30);
        }
        translate([0, 0, -0.01]) cylinder(d = 90, h = 30.02);
    }
}

