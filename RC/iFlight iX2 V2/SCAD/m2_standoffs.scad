/**
 * M2 Standoff Set for the iFlight iX2 V2 2.5" frame
 *
 * I tried to mount a Hobbywing XRotor F4 Nano / 4-in-1 20A ESC
 * combo together with an AKK FX2 VTX into the iFlight iX2 V2
 * frame. The provided standoffs make the stack to high to fit
 * into 20mm clearance so I designed my own set of standoffs. 
 * I mount the whole stack on long 20/25mm M2 screws.
 */

$fn = 64;

/**
 * This module can generate the different sorts of standoffs.
 */
module standoff(height = 1.2, m3adapter = false, oRing = false) {
    difference() {
        union() {
            cylinder(d = 4.2, h = height);
            if (m3adapter) {
                translate([0, 0, -2]) cylinder(d = 3.0, h = 2);
            }
            if (oRing) {
                cylinder(d = 5, h = 1);
            }
        }
        translate([0, 0, -2.01]) cylinder(d = 2.1, h = height + 2.02);
    }
}

module upperStandoff() {
    difference() {
        union() {
            cylinder(d = 4.2, h = 4);
            translate([0, 0, 4]) cylinder(d = 3.0, h = 1);
            cylinder(d = 5, h = 1);
        }
        translate([0, 0, -2.01]) cylinder(d = 2.1, h = 5 + 2.02);
    }
}

/**
 * This generates the lower standoffs. They adapt the M3 holes of the frame
 * into an M2 standoff with 3mm height.
 */
module lowerStandoffs() {
    for (pos = [[0, 0], [0, 8], [8,0], [8,8]]) {
        rotate([180, 0, 0]) translate([pos[0], pos[1], 3]) standoff(3, true);
    }
}

module middleStandoffs() {
        for (pos = [[0, 0], [0, 8], [8,0], [8,8]]) {
        translate([pos[0], pos[1], 0]) standoff(4, false, true);
    }
}

module upperStandoffs() {
        for (pos = [[0, 0], [0, 8], [8,0], [8,8]]) {
        translate([pos[0], pos[1], 0]) upperStandoff();
    }    
}

translate([0, -10, 6]) lowerStandoffs();
middleStandoffs();
translate([0, 20, 0]) upperStandoffs();



