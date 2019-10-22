/**
 * TBS Crossfire Nano mount for Armattan Chameleon (w/ cap mount)
 * 
 * This mount is intended for the Armattan Chameleon and holds
 * a TBS Crossfire Nano receiver (with heat shrink) and additionally 
 * a cap for noise reduction (default ring fits Panasonic 
 * FR-series 1000uF 35V cap).
 *
 * You need to replace the back standoffs with regular standoffs
 * to fit this mount.
 */ 
$fn = 64;

washer_diameter = 7;
strut_height = 2;
standoff_diameter = 5.6;
hole_spacing_back = 26;
washer_diameter = 7;
bend_length = 8;


// RX
rx_width = 12 ;
rx_length = 21;
rx_bevel_height = 4;
rx_bevel_width = 1;
zip_tie_width = 3.5;
zip_tie_height = 1.4;

cap_diameter = 13.2;
cap_retention_height = 8;

// standoff diameter + ring (uses a fixed value because 8.5 seems to be the magic number
// to make everything flush with the back end of the frame
sodpr = standoff_diameter + 2.4; // standoff_diameter + 2.4
// cap diameter plus ring
cdpr = cap_diameter + 2.4;
// hole spacing back half
hsbh = hole_spacing_back / 2;
// space between back struts
strut_spacing = hole_spacing_back - washer_diameter;
// bend length half
blh = bend_length / 2;
// strut spacing half
ssh = strut_spacing / 2;

module rx_mount() {

    // rx module mount
    difference() {
        union() {
            // transition struts
            hull() {
                translate([hsbh, 0, 0]) cylinder(d = washer_diameter, h = strut_height);
                translate([hsbh, 34, 0]) cylinder(d = washer_diameter, h = strut_height);
            }
            hull() {
                translate([-hsbh, 0, 0]) cylinder(d = washer_diameter, h = strut_height);
                translate([-hsbh, 34, 0]) cylinder(d = washer_diameter, h = strut_height);
            }            
            
            hull() {
                translate([hsbh, 0, 0]) cylinder(d = sodpr, h = strut_height);
                translate([hsbh, blh, 0]) cylinder(d = washer_diameter, h = strut_height);
            }
            hull() {
                translate([-hsbh, 0, 0]) cylinder(d = sodpr, h = strut_height);
                translate([-hsbh, blh, 0]) cylinder(d = washer_diameter, h = strut_height);
            }
            
            translate([-ssh, ssh - sodpr/2, 0]) cube([strut_spacing, rx_length + 7, 2]);
            
            // bevels 
            translate([rx_width/2 + rx_bevel_width, ssh - sodpr/2 + 1, 2]) rotate([0, 0, 90]) {
                cube([rx_length, rx_bevel_width, rx_bevel_height]);
                translate([0, rx_width + rx_bevel_width, 0]) cube([rx_length, rx_bevel_width, rx_bevel_height]);
                hull() {
                    translate([rx_length - 1, rx_width + rx_bevel_width, 0]) cube([2, rx_bevel_width, rx_bevel_height]);
                    translate([rx_length + 2, rx_width + rx_bevel_width, 0]) cube([4, rx_bevel_width, 2 * rx_bevel_height]);
                }
                translate([-rx_bevel_width, rx_width + rx_bevel_width - 3, 0]) cube([rx_bevel_width, 4, rx_bevel_height]);
                translate([rx_length + 2, 0, 0]) cube([rx_bevel_width, 3, 2 * rx_bevel_height]);
                hull() {
                    translate([rx_length + 2, 0, 0]) cube([rx_bevel_width, rx_bevel_width, 2 * rx_bevel_height]);
                    translate([rx_length, 0, 0]) cube([rx_bevel_width, rx_bevel_width, rx_bevel_height]);
                }    
            }
            
            translate([hole_spacing_back/2 + 0.6, 25.8, cdpr/2 + strut_height * 0.75]) 
            rotate([90, -90, 0]) difference() {
                hull() {
                    cylinder(d = cdpr, h = cap_retention_height);
                    translate([-cdpr /2, -cdpr/2 * 0.6 + 1.9, 0]) cube([1, cdpr * 0.6, cap_retention_height]);
                }
                translate([0, 0, -0.01]) cylinder(d = cap_diameter, h = cap_retention_height + 0.02);
            }
        }
        // holes for standoffs
        translate([hsbh, 0, -0.01]) cylinder(d = standoff_diameter, h = strut_height + 0.02);
        translate([-hsbh, 0, -0.01]) cylinder(d = standoff_diameter, h = strut_height + 0.02);
        
        translate([-strut_spacing, sodpr/2 + 14 - zip_tie_width, -0.01]) cube([strut_spacing * 2, zip_tie_width, zip_tie_height + 0.01]);
    }
}

rx_mount();