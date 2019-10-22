include <19-inch-rack-mounts.scad>
use <rounded_box.scad>

/**
 * The total height of the bracket, corresponds to the height of the compartment
 * the bracket will be mounted to.
 */
compartment_height = 129;

/**
 * How far into the compartment does the bracket reach?
 */
bracket_depth = 60;

/**
 * Support walls will be this thick for reinforcment of the rails.
 */
rail_support = 5;
rail_offset = 5;
nut_thickness = 4.1;
bracket_width = 22;
first_hu_z_offset = 25;
second_hu_offset = 17.5;
cross_brace_width = 8;
screw_head_diameter = 7.2;
screw_hole_diameter = 4;

module bracket() {
    
    difference() {
        hole_spacing = compartment_height / 3;
        hole_offset = hole_spacing / 2;
        hole_additional_offset = [0, -10, 0];
        hole_shifting = [0.6 * bracket_depth/2, -15, 0.6 * bracket_depth / 2];

        // the main body
        translate([bracket_width, 0, 0]) rotate([0, -90, 0]) box_with_round_edges_3d(width = bracket_depth, depth = compartment_height, height = bracket_width);
        // cutout to save filament & print time (requires use of standoffs later
        translate([bracket_width - rail_support - slack, rail_support, rail_support]) rotate([0, -90, 0]) box_with_round_edges_3d(width = bracket_depth, depth = compartment_height - 2 * rail_support, height = bracket_width - rail_support);
        for(i = [0:2]) {
            translate([0, hole_offset + i * hole_spacing + hole_additional_offset[i], bracket_depth / 2 + hole_shifting[i]]) {
                translate([-1, 0, 0]) rotate([0, 90, 0]) cylinder(d = screw_hole_diameter, h = bracket_width * 1.5);
                translate([bracket_width - 1, 0, 0]) rotate([0, 90, 0]) cylinder(d = screw_head_diameter, h = 10);
                translate([bracket_width - 3 + slack, 0, 0]) rotate([0, 90, 0]) cylinder(d1 = screw_hole_diameter, d2 = screw_head_diameter, h = 2 );
            }        
        }
    }
    
    // construct the two rails on top of the base
    translate([bracket_width, 0, 0]) {
        
        // Rail mount for the first power strip. Mounting is inverted on this one, so the rails
        // need to be set back a bit.
        translate([0, rail_offset, first_hu_z_offset]) {
            
            // angular support to top of the rail
            hull() {
                cube([0.1, rail_support, 5 * rail_support]);
                cube([hu_width, rail_support, 2 * hu_thickness + nut_thickness]);
            }
            
            // angular support to bottom of the rail
            hull() {
                translate([0, hu_height + rail_support, 0]) cube([0.1, rail_support, 5 * rail_support]);
                translate([0, hu_height + rail_support, 0]) cube([hu_width, rail_support, 2 * hu_thickness + nut_thickness]);
            }
            
            // the rail itself
            translate([0, rail_support, 0]) rack_mount_rail(hu = 1);
            translate([0, rail_support, hu_thickness]) rack_mount_rail_nut_trap(hu = 1);
            translate([0, rail_support, hu_thickness + nut_thickness]) rack_mount_rail(hu = 1);
        }
        
        // Rail mount for the second power strip. The rail is offset quite a bit, so we have to support it
        translate([second_hu_offset, 0, 0]) {
            translate([0, compartment_height - rail_offset - hu_height - 2 * rail_support, 0]) {
                
                // angular support to top of the rail
                hull() {
                    cube([hu_width, rail_support, hu_thickness * 2 + nut_thickness]);
                    translate([-second_hu_offset, 0, 0]) cube([0.1, rail_support, 3 * hu_width]);
                }
                // angular support to bottom of the rail
                hull() {
                    translate([0, hu_height + rail_support, 0]) cube([hu_width, rail_support, hu_thickness * 2 + nut_thickness]);
                    translate([-second_hu_offset, hu_height + rail_support, 0]) cube([0.1, rail_support, 3 * hu_width]);
                }
                
                // cross-brace to support the rail itself
                hull() {
                    translate([0, rail_support, 0]) cylinder(d = cross_brace_width, h = hu_thickness * 2 + nut_thickness);
                    translate([-second_hu_offset, rail_support + hu_height, 0]) cylinder(d = cross_brace_width, h = hu_thickness * 2 + nut_thickness);
                }
                // cross-brace to support the rail itself
                hull() {
                    translate([-second_hu_offset, rail_support, 0]) cylinder(d = cross_brace_width, h = hu_thickness * 2 + nut_thickness);
                    translate([0, rail_support + hu_height, 0]) cylinder(d = cross_brace_width, h = hu_thickness * 2 + nut_thickness);
                }
                
                // the rail itself
                translate([0, rail_support, 0]) rack_mount_rail(hu = 1);
                translate([0, rail_support, hu_thickness]) rack_mount_rail_nut_trap(hu = 1);
                translate([0, rail_support, hu_thickness + nut_thickness]) rack_mount_rail(hu = 1);
            }    
        }         
    }
}

/**
 * Standoff to use for mounting the bracket to the compartment. In order to save filament
 * and print time, the main bracket has a large cutout, so you'll need these standoffs to
 * be able to screw it down tightly without breaking it.
 */
module standoff() {
    difference() {
        cylinder(d = 1.8 * screw_head_diameter, h = bracket_width - rail_support - 0.1);
        translate([0, 0, -slack]) cylinder(d = screw_hole_diameter, h = bracket_width * 1.1);
    }
}

// output the two brackets
bracket();
translate([-5, 0, 0]) mirror([1, 0, 0]) bracket();

// output a total of 6 standoffs
for(offset_x = [60, 85]) {
    for (offset_y = [0, 25, 50]) {
        translate([offset_x, offset_y, 0]) standoff();
    }
}
