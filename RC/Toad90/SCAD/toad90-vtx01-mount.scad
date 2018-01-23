/**
 * Eachine VTX01 mount for Toad90 frame
 *
 * by Hendrik Busch, 2018 (https://github.com/hmbusch)
 *
 * The Toad90 frame is so small, that I had trouble fitting a VTX
 * inside while using a 3-board-stack, so I made a case for it to
 * mount on top of the quad.
 * The case is intended for the smaller Eachine VTX01 rather than
 * the VTX03 beacause here in Germany it is illegal to use more 
 * than 25mW of transmitting power - so why spend the extra money, 
 * space and weight.
 */
use <../../Universal/SCAD/eachine-vtx01.scad>;

$fn = 128;

// Set this to true if you want to use a ziptie to hold the
// box together, otherwise set it to false.
ziptie = true;

zLift = ziptie ? 1.4 : 0;

module ventilationSlot(length = 13) {
    hull() {
        translate([0, 0, -0.01]) cylinder (d = 1.5, h = 1.62 + zLift);
        translate([0, length, -0.01]) cylinder (d = 1.5, h = 1.62 + zLift);
    }
}

module case() {
    difference() {
        union() {
            // bottom
            translate([0, 0, 0]) cube([23.6, 17.6, 1.6 + zLift]);
            // left bevel
            translate([0, 0, zLift]) cube([1.6, 17.6, 7]);
            // right bevel
            translate([0, 0, zLift]) translate([22, 0, 0]) cube([1.6, 17.6, 7]);
            // back bevel
            translate([0, 0, zLift]) cube([23.6, 1.6, 7]);
            // antenna bevel
            translate([23.6/2 + 0.75 - 6/2, 16, 0]) cube([6, 5, 2.6 + zLift]);
            // front bevel
            translate([0, 17.6 - 1.6, zLift]) cube([23, 1.6, 7]);
            // support corner
            translate([20, 15, zLift]) cube([2, 1, 2.6]);
            // support antenna
            translate([23.6/2 + 0.75 - 6/2, 15, zLift]) cube([6, 1, 2.6]);
            // support near cables
            translate([12.4, 1.6, zLift]) cube([2, 1, 2.6]);
            // base for rx antenna protection
            hull() {
                translate([23.6 - 6, 17.6 - 1.6, 0]) cube([6, 1.6, 7 + zLift]);
                translate([23.6 - 6/2, 17.6 + 1 + 6/2, 0]) cylinder(d = 6, h = 7 + zLift);
            }
        }
        // cutout for cables
        translate([14.4, -0.01 , 1.8 + zLift]) cube([7.5, 1.62, 6]);
        
        // cutout for button
        translate([2.6, 13 , 0.6 + zLift]) cube([5, 5, 3.5]);
        
        // cutout for antenna
        translate([23.6/2 + 0.75 - 6/2, 15.996, 2.6 + zLift]) cube([6, 3, 5.2]);
        
        // cutout for rx antenna protection
        translate([23.6 - 6/2, 17.6 + 1 + 6/2, -0.01]) cylinder(d1 = 3.2, d2 = 3.05, h = 7.02 + zLift);
        
        // ventilation slots
        for(offset = [ 4 : 3 : 14 ]) {
            translate([19.8, offset, 0]) rotate([0, 0, 90]) ventilationSlot(length = 16);
        }
        translate([0, 3.8, 3.5 + zLift]) rotate([0, 90, 0]) ventilationSlot(length = 10);
        translate([22.0, 3.8, 3.5 + zLift]) rotate([0, 90, 0]) ventilationSlot(length = 10);
        
        // cutout for ziptie
        if (ziptie) {
            translate([-0.01 + 23.62/2, 2* 17.6/3 - 1, 0.69]) cube([23.62, 5 , 1.4], center = true);
            translate([0, 2* 17.6/3 - 1, -1]) rotate([0, 45, 0]) cube([5, 5, 5], center = true);
            translate([23.6, 2* 17.6/3 - 1, -1]) rotate([0, 45, 0]) cube([5, 5, 5], center = true);            
        }
    }    
}

module mountableCase() {    
    difference() {
        union() {
            case();
            hull() {
                translate([3.3, -2.3, 0]) cylinder(d = 5.4, h = 1.6 + zLift);
                translate([0, 0, 0]) cube([6.6, 1, 1.6 + zLift]);
            }
            hull() {
                translate([3.3 + 17, -2.3, 0]) cylinder(d = 5.4, h = 1.6 + zLift);
                translate([17, 0, 0]) cube([6.6, 1, 1.6 + zLift]);
            }
        }
        translate([3.3, -2.3, -0.01]) cylinder(d = 2.2, h = 1.62 + zLift);
        translate([3.3 + 17, -2.3, -0.01]) cylinder(d = 2.2, h = 1.62 + zLift);
    }
}

module lid() {
    difference() {
        union() {
            // main lid & bevels
            cube([23.6, 17.6, 1.6]);    
            translate([1.7, 1.7, -1.6]) cube([1.6, 4.5, 2.6]);
            translate([20.3, 1.8, -1.6]) cube([1.6, 14.2, 2.6]);
            translate([23.6/2 + 0.75 - 5/2, 16.6, -0.6]) cube([5, 1, 0.6]);
            translate([14.6, 0 , -1.6]) cube([7.1, 1.6, 2]);
            
            // antenna support
            hull() {
                translate([23.6/2 + 0.75 - 10 /2, 16.6, 0]) cube([10, 1, 1.6]);
                translate([23.6/2 + 0.75 - 6/2, 18, 0]) cube([6, 10, 1.6]);           
            }
            
            // base for rx antenna protection
            hull() {
                translate([23.6 - 6, 17.6 - 1.6, 0]) cube([6, 1.6, 1.6]);
                translate([23.6 - 6/2, 17.6 + 1 + 6/2, 0]) cylinder(d = 6, h = 1.6);
            }
        }
        
        // ziptie cutouts
        if (ziptie) {
            translate([0, 2* 17.6/3 - 1, 3.5]) rotate([0, 45, 0]) cube([5, 5, 5], center = true);
            translate([23.6, 2* 17.6/3 - 1, 3.5]) rotate([0, 45, 0]) cube([5, 5, 5], center = true);
        }
        
        // cutout for antenna support ziptie
        translate([23.6/2 + 0.75 - 3.6/2, 23, -0.01]) cube([3.6, 2.5, 1.62]);           
        
        // identation for seven-segment-display
        translate([1.7, 1.7 + 4.5, -0.01]) cube([7.2, 8.2, 1.01]);
        
        // cutout for rx antenna protection
        translate([23.6 - 6/2, 17.6 + 1 + 6/2, -0.01]) cylinder(d = 3.1, h = 1.62);
        
        // ventilation slots
        translate([19, 3, 0]) rotate([0, 0, 90]) ventilationSlot(length = 14);
        for(offset = [6 : 3 : 15]) {
            translate([19, offset, 0]) rotate([0, 0, 90]) ventilationSlot(length = 8);
        }
    }
}

module assembly() {
    mountableCase();
    translate([0, 0, 7.1 + zLift]) lid();
    %translate([1.8, 1.8, 2.8]) vtx01();
}

module print() {
    mountableCase();
    translate([50, 0, 1.6]) rotate([0, 180, 0]) lid();
}

print();

// To see an assembled version, uncomment the line below (and
// comment the line above).
//assembly();