include <../../Various/SCAD/rounded_box.scad>;

switch_x = 33;
switch_y = 35;
switch_z = 20;

switch_stalk_dia = 12.2;

box_x = 40;
box_y = 41;
box_z = 26;

mount_x = 15;
mount_y = box_y;
mount_z = 5;

mount_screw_hole_dia = 3.7;
mount_screw_head_dia = 7;
mount_screw_head_height = 3.5;

$fn = 64;

f = 0.01;
df = 2 * f;

difference() {
    union() {
        // main body        
        translate([0, box_y, 0])
            rotate([90, 0, 0])
                box_with_round_edges_3d(
                    [box_x, box_z, box_y], 
                    edges = [false, false, true, true]);
        
        // mounting flanges
        translate([-mount_x, 0, 0])
            box_with_round_edges_3d(
                    [mount_x, mount_y, mount_z], 
                    edges = [true, false, true, false]);
        translate([box_x, 0, 0])
            box_with_round_edges_3d(
                    [mount_x, mount_y, mount_z], 
                    edges = [false, true, false, true]);
    }
    
    // hollow out for switch
    translate([(box_x - switch_x)/2, box_y - switch_y, (box_z - switch_z)/2])
       cube([switch_x, switch_y + f, switch_z]);
    
    // hole for switch stalk
    translate([box_x/2, box_y - f, box_z/2])
        rotate([90, 0, 0])
            cylinder(d = switch_stalk_dia, h = box_y + df);
    
    // mounting holes
    for(offset_x = [-mount_x/2, box_x + mount_x/2]) {
        for (offset_y = [mount_y/4, mount_y/4 * 3]) {
            translate([offset_x, offset_y, -f])
                mounting_screw();
        }
    }
}

module mounting_screw() {
    cylinder(d = mount_screw_hole_dia, h = mount_z + df);
    translate([0, 0, mount_z - mount_screw_head_height + df])
        cylinder(
            d1 = mount_screw_hole_dia, 
            d2 = mount_screw_head_dia, 
            h = mount_screw_head_height);
}




