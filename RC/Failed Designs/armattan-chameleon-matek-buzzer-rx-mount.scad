/*
 * Armattan Chameleon Buzzer & Receiver Mount
 *   for use with Matek FCHUB-VTX & Matek F405 OSD combo
 */

$fn = 64;

// struts
hole_spacing_front = 30.5;
hole_spacing_back = 26;
front_to_back_distance = 48;
bend_length = 8;
washer_diameter = 7;
washer_height = 1.4;
strut_height = 3;
standoff_diameter = 6.3;
interlinking_diameter = 4;
m3_hole = 3.2;

// RX
rx_width = 11 ;
rx_length = 16.1;
rx_bevel_height = 2;
rx_bevel_width = 1;
zip_tie_width = 3.5;
zip_tie_height = 1.4;

// buzzer
buzzer_horn_diameter = 12.2;
buzzer_z_offset = 3.5;
buzzer_horn_width = 8;
buzzer_horn_length = 4;
buzzer_width = 14;
buzzer_length = 18;
buzzer_pcb_height = 2;
buzzer_cover_strut_height = buzzer_z_offset + 0.2;

// LED bar
led_bar_width = 35;
led_bar_height = 10.8;
led_bar_depth = 2;
led_cable_width = 4;
led_cable_height = 1.5;

/* 
 * SHORTCUT VARIABLES
 */

// hole spacing front half 
hsfh = hole_spacing_front / 2;
// hole spacing back half
hsbh = hole_spacing_back / 2;
// standoff diameter + ring (uses a fixed value because 8.5 seems to be the magic number
// to make everything flush with the back end of the frame
sodpr = 6.3 + 2.4; // standoff_diameter + 2.2
// bend length half
blh = bend_length / 2;
// space between back struts
strut_spacing = hole_spacing_back - washer_diameter;
// strut spacing half
ssh = strut_spacing / 2;
// buzzer horn width half
bhwh = buzzer_horn_width / 2;
// buzzer width half
bwh = buzzer_width / 2;
// led bar width half
lbwh = led_bar_width / 2;
// led bar depth half
lbdh = led_bar_depth / 2;
// led cable width half
lcwh = led_cable_width / 2;


module struts() {    
    difference() {
        union() {
            // front struts
            hull() {
                translate([hsfh, 0, 0]) cylinder(d = washer_diameter, h = washer_height);
                translate([hsfh, bend_length, 0]) cylinder(d = washer_diameter, h = washer_height);
            }
            hull() {
                translate([-hsfh, 0, 0]) cylinder(d = washer_diameter, h = washer_height);
                translate([-hsfh, bend_length, 0]) cylinder(d = washer_diameter, h = washer_height);
            }

            // front interlinking strut
            hull() {
                translate([hsfh, 0, 0]) cylinder(d = interlinking_diameter, h = washer_height);
                translate([-hsfh, 0, 0]) cylinder(d = interlinking_diameter, h = washer_height);
            }

            // front transition struts
            hull() {
                translate([hsfh, bend_length, 0]) cylinder(d = washer_diameter, h = washer_height);
                translate([hsbh, bend_length * 2, 0]) cylinder(d = washer_diameter, h = strut_height);
            }
            hull() {
                translate([-hsfh, bend_length, 0]) cylinder(d = washer_diameter, h = washer_height);
                translate([-hsbh, bend_length * 2, 0]) cylinder(d = washer_diameter, h = strut_height);
            }

            // back transition struts
            hull() {
                translate([hsbh, bend_length * 2, 0]) cylinder(d = washer_diameter, h = strut_height);
                translate([hsbh, front_to_back_distance - blh, 0]) cylinder(d = washer_diameter, h = strut_height);
            }
            hull() {
                translate([-hsbh, bend_length * 2, 0]) cylinder(d = washer_diameter, h = strut_height);
                translate([-hsbh, front_to_back_distance - blh, 0]) cylinder(d = washer_diameter, h = strut_height);
            }

            // back struts
            hull() {
                translate([hsbh, front_to_back_distance - blh, 0]) cylinder(d = washer_diameter, h = strut_height);
                translate([hsbh, front_to_back_distance, 0]) cylinder(d = sodpr, h = strut_height);
            }
            hull() {
                translate([-hsbh, front_to_back_distance - blh, 0]) cylinder(d = washer_diameter, h = strut_height);
                translate([-hsbh, front_to_back_distance, 0]) cylinder(d = sodpr, h = strut_height);
            }
        }
        
        // front M3 holes
        translate([hsfh, 0, -0.01]) cylinder(d = m3_hole, h = washer_height + 0.02);
        translate([-hsfh, 0, -0.01]) cylinder(d = m3_hole, h = washer_height + 0.02);
     
        // back holes for standoffs
        translate([hsbh, front_to_back_distance, -0.01]) cylinder(d = standoff_diameter, h = strut_height + 0.02);
        translate([-hsbh, front_to_back_distance, -0.01]) cylinder(d = standoff_diameter, h = strut_height + 0.02);
    }
}

module buzzer_mount(){
    difference() {
        translate([0, 2, 0]) cube([strut_spacing, strut_spacing - 2, buzzer_z_offset + buzzer_pcb_height]);
        translate([ssh - bwh, -1, buzzer_z_offset]) cube([buzzer_width, buzzer_length, buzzer_pcb_height + 0.01]);
        translate([ssh, ssh, -0.01]) cylinder(d = buzzer_horn_diameter, h = buzzer_z_offset + 0.02);
        translate([ssh - bhwh, strut_spacing - buzzer_horn_length - 1, -0.01]) cube([buzzer_horn_width, buzzer_horn_length+1.01, buzzer_z_offset + 0.02]);
    }
}

module buzzer_cover() {
    difference() {
        union() {
            // back transition struts
            hull() {
                translate([hsbh, 0, 0]) cylinder(d = washer_diameter, h = buzzer_cover_strut_height);
                translate([hsbh, sodpr + buzzer_length - blh, 0]) cylinder(d = washer_diameter, h = buzzer_cover_strut_height);
            }
            hull() {
                translate([-hsbh, 0, 0]) cylinder(d = washer_diameter, h = buzzer_cover_strut_height);
                translate([-hsbh, sodpr + buzzer_length - blh, 0]) cylinder(d = washer_diameter, h = buzzer_cover_strut_height);
            }

            // back struts
            hull() {
                translate([hsbh, sodpr + buzzer_length - blh, 0]) cylinder(d = washer_diameter, h = buzzer_cover_strut_height);
                translate([hsbh, sodpr + buzzer_length, 0]) cylinder(d = sodpr, h = buzzer_cover_strut_height);
            }
            hull() {
                translate([-hsbh, sodpr + buzzer_length - blh, 0]) cylinder(d = washer_diameter, h = buzzer_cover_strut_height);
                translate([-hsbh, sodpr + buzzer_length, 0]) cylinder(d = sodpr, h = buzzer_cover_strut_height);
            }
         
            translate([-ssh, ssh - sodpr/2, 0]) cube([strut_spacing, strut_spacing, 1]);
        }
        // back holes for standoffs
        translate([hsbh, sodpr + buzzer_length, -0.01]) cylinder(d = standoff_diameter, h = buzzer_cover_strut_height + 0.02);
        translate([-hsbh, sodpr + buzzer_length, -0.01]) cylinder(d = standoff_diameter, h = buzzer_cover_strut_height + 0.02);
        
        // tolerance
        translate([-ssh, ssh - sodpr/2 - 0.35, 1]) cube([strut_spacing + 0.2, strut_spacing + 0.2, buzzer_cover_strut_height]);
    }
}

module rx_mount() {

    // rx module mount
    difference() {
        union() {
            // transition struts
            hull() {
                translate([hsbh, 0, 0]) cylinder(d = washer_diameter, h = strut_height);
                translate([hsbh, 28, 0]) cylinder(d = washer_diameter, h = strut_height);
            }
            hull() {
                translate([-hsbh, 0, 0]) cylinder(d = washer_diameter, h = strut_height);
                translate([-hsbh, 28, 0]) cylinder(d = washer_diameter, h = strut_height);
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
            translate([rx_width/2 + rx_bevel_width/2, ssh - sodpr/2 + 1, 2]) rotate([0, 0, 90]) {
                cube([rx_length, rx_bevel_width, rx_bevel_height]);
                translate([0, rx_width, 0]) cube([rx_length, rx_bevel_width, rx_bevel_height]);
                hull() {
                    translate([rx_length - 1, rx_width, 0]) cube([2, rx_bevel_width, rx_bevel_height]);
                    translate([rx_length + 2, rx_width, 0]) cube([4, rx_bevel_width, 2 * rx_bevel_height]);
                }
                translate([-rx_bevel_width, rx_width + rx_bevel_width - 4, 0]) cube([rx_bevel_width, 4, rx_bevel_height]);
                translate([rx_length + 2, 0, 0]) cube([rx_bevel_width, 3, 2 * rx_bevel_height]);
                hull() {
                    translate([rx_length + 2, 0, 0]) cube([rx_bevel_width, rx_bevel_width, 2 * rx_bevel_height]);
                    translate([rx_length, 0, 0]) cube([rx_bevel_width, rx_bevel_width, rx_bevel_height]);
                }    
            }
        }
        // holes for standoffs
        translate([hsbh, 0, -0.01]) cylinder(d = standoff_diameter, h = strut_height + 0.02);
        translate([-hsbh, 0, -0.01]) cylinder(d = standoff_diameter, h = strut_height + 0.02);
        
        translate([-strut_spacing, sodpr/2 + 14 - zip_tie_width, -0.01]) cube([strut_spacing * 2, zip_tie_width, zip_tie_height + 0.01]);
    }
    
//    translate([-ssh - sodpr, -2 -sodpr / 2, -10]) rotate([65, 0, 0]) {
//        cube([strut_spacing + 2 * sodpr, 4, 15]);
//        translate([ssh + sodpr, 4.5, 15/2]) rotate([90, 0, 0]) cylinder(d = 8, h = 5, $fn = 6);
//    }
}

module led_mount(led_strut_height = strut_height) {
    // standoff mounting
    difference() {
        union() {
            hull() {
                translate([hsbh, 0, 0]) cylinder(d = sodpr, h = led_strut_height);
                translate([hsbh - sodpr/2 - 2, sodpr/2, 0]) cube([sodpr + 2.25, 1, led_strut_height]);
                
            }
            hull() {
                translate([-hsbh, 0, 0]) cylinder(d = sodpr, h = led_strut_height);
                translate([-hsbh - sodpr/2 + - 0.25, sodpr/2, 0]) cube([sodpr + 2.25, 1, led_strut_height]);
            }
        }
        // holes for standoffs
        translate([hsbh, 0, -0.01]) cylinder(d = standoff_diameter, h = led_strut_height + 0.02);
        translate([-hsbh, 0, -0.01]) cylinder(d = standoff_diameter, h = led_strut_height + 0.02);
    }
    difference() {
        translate([-lbwh, sodpr/2, 0]) cube([led_bar_width, led_bar_depth + 3, led_bar_height + 3.2]);
        translate([-lbwh - 0.01, sodpr/2 + 3, 1.6]) cube([led_bar_width + 0.02, led_bar_depth + 0.01, led_bar_height]);
        translate([-lbwh - 0.01, sodpr/2 + 3 - led_cable_height, led_strut_height]) cube([led_bar_width + 0.02, led_cable_height  + 0.01, led_cable_width]);
        translate([0, sodpr, led_strut_height + lcwh]) rotate([90, 0, 0]) cylinder(d = led_cable_width, h = led_bar_depth + 3);
    }
}

module partBuzzerMount() {
    difference() {
        union() {
            struts();    
            translate([-ssh, front_to_back_distance - strut_spacing - sodpr/2, 0]) buzzer_mount();  
        }
        hull() {
            translate([-hsbh + sodpr/2 + 1.3, front_to_back_distance - sodpr/2, -0.01]) cylinder(d = led_cable_width, h = led_cable_height + 0.61);
            translate([-hsbh + sodpr/2 - 1, front_to_back_distance - ssh - sodpr/2, -0.01]) cylinder(d = led_cable_width, h = led_cable_height + 0.61);
        }
        hull() {
            translate([-hsbh + sodpr/2 - 1, front_to_back_distance - ssh - sodpr/2, -0.01]) cylinder(d = led_cable_width, h = led_cable_height + 0.61);
            translate([-hsbh + sodpr/2, front_to_back_distance - 2 * ssh - sodpr/2, -0.01]) cylinder(d = led_cable_width, h = led_cable_height + 0.61);
        }
    }
}

module partBuzzerCover() {
    buzzer_cover();
}

module partLedMount() {
    led_mount();
}

module partBuzzerCoverAndLedMount() {
    difference() {
        union() {
            buzzer_cover();
            translate([0, sodpr + buzzer_length, 0]) led_mount(buzzer_cover_strut_height);
        }
        // tolerance
        translate([-ssh, ssh - sodpr/2 - 0.35, 1]) cube([strut_spacing + 0.2, strut_spacing + 0.2, buzzer_cover_strut_height]);
    }
}

module print() {
    partBuzzerMount();
    translate([2 * strut_spacing, 0, 0]) partBuzzerCover();
    translate([2 * strut_spacing, 40, 0]) partLedMount();
    translate([4 * strut_spacing, 0, 0]) partBuzzerCoverAndLedMount();
}

module assemblyTypeA() {
    color("Coral") partBuzzerMount();
    color("CornflowerBlue") translate([0, front_to_back_distance - (sodpr + buzzer_length), strut_height + buzzer_cover_strut_height]) rotate([180, 0, 180]) partBuzzerCover();
    color("MediumSeaGreen") translate([0, front_to_back_distance, strut_height * 2 + buzzer_cover_strut_height]) rotate([180, 0, 180]) color("Green") partLedMount();
}

module assemblyTypeB() {
    color("Coral") partBuzzerMount();
    color("CornflowerBlue") translate([0, front_to_back_distance - (sodpr + buzzer_length), strut_height + buzzer_cover_strut_height]) rotate([180, 0, 180]) partBuzzerCoverAndLedMount();
    color("Red") translate([0, front_to_back_distance, 20]) rotate([180, 0, 0]) rx_mount();
}

//print();
//assemblyTypeA();
assemblyTypeB();

//rx_mount();

