$fn = 64;

in = 25.4;
bracket_thickness = 5;
screw_hole_diameter = 5.5;
screw_head_diameter = 10;
screw_head_height = 4;
screw_hole_spacing = 133;
first_hole_offset = 5;

supply_width = 56;
supply_length = 112;
velcro_width = 15.5;

mounting_plate_width = 30;
mounting_plate_length = 50;

cable_slot_width = 5;
cable_slot_height = 2;

fudge = 0.01;

// Derived values, do not edit
pf = fudge;
nf = -fudge;
dpf = 2 * pf;
base_offset = first_hole_offset + screw_hole_diameter/2;

module mounting_post() {
    difference() {
        cube([mounting_plate_length + supply_width, mounting_plate_width, bracket_thickness]);
        translate([0, mounting_plate_width/2, nf]) {           
            translate([base_offset, 0, 0]) {
                cylinder(d = screw_hole_diameter, h = bracket_thickness + dpf);
                translate([0, 0, bracket_thickness - screw_head_height + pf])
                    cylinder(d1 = screw_hole_diameter, d2 = screw_head_diameter, h = screw_head_height + pf);
            }
            translate([base_offset + in, 0, 0]) {
                cylinder(d = screw_hole_diameter, h = bracket_thickness + dpf);
                translate([0, 0, bracket_thickness - screw_head_height + pf])
                    cylinder(d1 = screw_hole_diameter, d2 = screw_head_diameter, h = screw_head_height + pf);
            }
        }
    }
}

module final_part() {
    difference() {
        union() {
            // mounting posts
            mounting_post();
            translate([0, screw_hole_spacing, 0])
                mounting_post();
            
            // wide support plates w/ spacing for velcro
            plate_width = (screw_hole_spacing - mounting_plate_width - 2 * velcro_width) / 3;
            translate([mounting_plate_length, mounting_plate_width, 0]) 
                color("red") 
                    cube([supply_width, plate_width, bracket_thickness]);
            translate([mounting_plate_length, screw_hole_spacing - plate_width, 0]) 
                color("red") 
                    cube([supply_width, plate_width, bracket_thickness]);
            translate([mounting_plate_length, mounting_plate_width + plate_width + velcro_width, 0]) 
                color("red") 
                    cube([supply_width, plate_width, bracket_thickness]);
            
            // narrow support for velcro and sticky tape
            translate([mounting_plate_length + supply_width/4, 0, 0])
                color("green") 
                    cube([supply_width/2, screw_hole_spacing + mounting_plate_width, bracket_thickness]);
        }
        translate([first_hole_offset + in/2 , nf, nf]) cube([cable_slot_width, screw_hole_spacing + mounting_plate_width + dpf, cable_slot_height + pf]);
    }
}

translate([0, -mounting_plate_width/2, 0])
final_part();