use <../../Various/SCAD/rounded_box.scad>

$fn = 64;

begriplig_inner_dia = 20;
begriplig_outer_dia = 24.5;
begriplig_inner_height = 17;
begriplig_mounting_screw_dia = 5;
begriplig_mounting_screw_offset = 4;
begriplig_mounting_screw_protrusion = 5;

mount_cylinder_z = begriplig_inner_height - 5;

base_size_x = 40;
base_size_y = base_size_x;
base_size_z = 14;

wall_thickness = 3;

wemos_d1_mini_x = 32;
wemos_d1_mini_y = 27;
wemos_d1_mini_z = 8;

wemos_support_x = 4.5;
wemos_support_z = 4;
wemos_support_y_1 = 20;
wemos_support_y_2 = 4.5;

additional_space_z = 2;

cable_channel_dia = 4;

ventilation_z = 1.5;

usb_x = 12;
usb_z = 7;

cap_overlap = 5;

// Assert that the set parameters are ok
assert(base_size_z - wall_thickness > wemos_d1_mini_z + additional_space_z, "Base z-height is not high enough to house the Wemos module");
assert(base_size_x - 2 * wall_thickness > wemos_d1_mini_x, "Base x-width is not wide enough to house the Wemos module");
assert(base_size_y - 2 * wall_thickness > wemos_d1_mini_y, "Base y-length is not long enough to house the Wemos module");

module usb_cutout() {
    rotate([90, 0, 90])
        translate([usb_z/2, 0, 0])
            hull() {
                cylinder(d = usb_z, h = 2 * wall_thickness);
                translate([usb_x - usb_z, 0, 0])
                    cylinder(d = usb_z, h = 2 * wall_thickness);
            }
}

module stand() {
    union() {
        difference() {
            
            // Create the basic stand shape
            union() {
                box_with_round_edges_3d([base_size_x, base_size_y, base_size_z]);
                translate([base_size_x/2, base_size_y/2, base_size_z]) {
                    cylinder(d = begriplig_inner_dia, h = mount_cylinder_z);
                    translate([0, 0, mount_cylinder_z])
                        cube([8, 2, 1.5], center=true);
                }
            }
            
            // Create cutout for the Wemos module
            translate([wall_thickness/2, (base_size_y - wemos_d1_mini_y)/2, -0.01])
                cube([wemos_d1_mini_x, wemos_d1_mini_y, wemos_d1_mini_z + additional_space_z]);
            
            // Create cable channels
            translate([base_size_x/2, base_size_y/2 + begriplig_inner_dia/3, -0.01])
                cylinder(d = cable_channel_dia, h = base_size_z + mount_cylinder_z + 0.02);
            translate([base_size_x/2, base_size_y/2 - begriplig_inner_dia/3, -0.01])
                cylinder(d = cable_channel_dia, h = base_size_z + mount_cylinder_z + 0.02);
            
            // Create notch for mounting screw
            translate([(base_size_x - begriplig_inner_dia)/2, base_size_y/2 - begriplig_mounting_screw_dia/2, base_size_z + begriplig_mounting_screw_offset + 0.01])
                cube([begriplig_mounting_screw_protrusion, begriplig_mounting_screw_dia, mount_cylinder_z - begriplig_mounting_screw_offset]);
         
            // Some ventilation slits
            translate([base_size_x/4 - 1.5, -base_size_y/2, wemos_d1_mini_z - ventilation_z + additional_space_z])
                cube([base_size_x/2, 2 * base_size_y, ventilation_z - 0.01]);
            
            // USB cutout
            translate([-wall_thickness/2, (base_size_y - usb_x)/2, wemos_d1_mini_z/2 - 1])
                usb_cutout();
        }
        
        // Add Wemos supports
        translate([wall_thickness/2, base_size_y/2 - wemos_support_y_1/2, wemos_d1_mini_z + additional_space_z - wemos_support_z])
            cube([wemos_support_x, wemos_support_y_1, wemos_support_z]);
        translate([wall_thickness/2 + wemos_d1_mini_x - wemos_support_x, (base_size_y - wemos_d1_mini_y)/2, wemos_d1_mini_z + additional_space_z - wemos_support_z])
            cube([wemos_support_x, wemos_support_y_2, wemos_support_z]);
        translate([wall_thickness/2 + wemos_d1_mini_x - wemos_support_x, (base_size_y - wemos_d1_mini_y)/2 + wemos_d1_mini_y - wemos_support_y_2, wemos_d1_mini_z + additional_space_z - wemos_support_z])
            cube([wemos_support_x, wemos_support_y_2, wemos_support_z]);
    }
}

module cap() {
    difference() {
        cylinder(d = begriplig_outer_dia + 2 * wall_thickness, h = wall_thickness + cap_overlap);
        translate([0, 0, wall_thickness + 0.01])
            cylinder(d = begriplig_outer_dia, h = cap_overlap);
    }
}


stand();

translate([base_size_x + begriplig_outer_dia, base_size_y/2, 0])
    cap();