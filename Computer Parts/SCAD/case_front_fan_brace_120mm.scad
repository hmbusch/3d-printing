use <../../Various/SCAD/rounded_box.scad>

plate_x = 150;
plate_y = 150;
plate_z = 2;

fan_duct_dia = 118;
fan_center_dia = 43;
fan_hole_spacing = 105;
fan_strut_width = 9;
fan_screw_dia = 5;

rail_width = 9.5;
rail_length = plate_y * 0.8;
rail_screw_dia = 3.6;

$fn = 64;

slack = 0.01;

module center_hub_and_struts() {
    difference() {
        union() {
            // strut 1
            hull() {
                translate([fan_hole_spacing/2, fan_hole_spacing/2, 0]) cylinder(d = fan_strut_width, h = plate_z);
                translate([-fan_hole_spacing/2, -fan_hole_spacing/2, 0]) cylinder(d = fan_strut_width, h = plate_z);
            }
            
            // strut 2
            hull() {
                translate([-fan_hole_spacing/2, fan_hole_spacing/2, 0]) cylinder(d = fan_strut_width, h = plate_z);
                translate([fan_hole_spacing/2, -fan_hole_spacing/2, 0]) cylinder(d = fan_strut_width, h = plate_z);
            }
           
            // center hub
            cylinder(d = fan_center_dia, h = plate_z);
        }
        // center hub cutout
        translate([0, 0, -slack]) cylinder(d = fan_center_dia - 2 * fan_strut_width, h = plate_z + 2 * slack);
    }
}

module fan_hole_pattern() {
    translate([fan_hole_spacing/2, fan_hole_spacing/2, -slack]) cylinder(d = fan_screw_dia, h = plate_z + 2*slack);
    translate([fan_hole_spacing/2, -fan_hole_spacing/2, -slack]) cylinder(d = fan_screw_dia, h = plate_z + 2*slack);
    translate([-fan_hole_spacing/2, fan_hole_spacing/2, -slack]) cylinder(d = fan_screw_dia, h = plate_z + 2*slack);
    translate([-fan_hole_spacing/2, -fan_hole_spacing/2, -slack]) cylinder(d = fan_screw_dia, h = plate_z + 2*slack);
}

module rail() {
    difference() {
        // the rail, at double width, so we don't have problems with rounded edges touching the plate.
        // We'll just 'sink' it into the plate.
        box_with_round_edges_3d([2 * rail_width, rail_length, plate_z] , 5);
        
        // screw cutout 1
        hull() {
            translate([rail_width/2, rail_length * 0.05, -slack]) cylinder(d = rail_screw_dia, h = plate_z + 2*slack);
            translate([rail_width/2, rail_length * 0.45, -slack]) cylinder(d = rail_screw_dia, h = plate_z + 2*slack);
        }
        
        // screw cutout 2
        hull() {
            translate([rail_width/2, rail_length * 0.55, -slack]) cylinder(d = rail_screw_dia, h = plate_z + 2*slack);
            translate([rail_width/2, rail_length * 0.95, -slack]) cylinder(d = rail_screw_dia, h = plate_z + 2*slack);
        }
    }
}

module mounting_plate() {
    difference() {
        // the plate itself
        box_with_round_edges_3d([plate_x, plate_y, plate_z] , 10);
        
        // cutout for the fan
        translate([plate_x/2, plate_y/2, -slack]) cylinder(d = fan_duct_dia, h = plate_z + 2 * slack);
    }
}

module fan_brace_complete() {
    difference() {
        union() {
            // plate
            mounting_plate();
            // rails
            translate([-rail_width, (plate_y - rail_length)/2, 0]) rail();
            translate([plate_x + rail_width, rail_length + (plate_y - rail_length)/2, 0]) rotate([0, 0, 180]) rail();
            // center hub & struts
            translate([plate_x/2, plate_y/2, 0]) center_hub_and_struts();
        }
        translate([plate_x/2, plate_y/2, 0]) fan_hole_pattern();
    }
}

fan_brace_complete();