use <../../Various/SCAD/rounded_box.scad>
include <gopro-mount-library.scad>

camera_x = 108;
camera_y = 24;
camera_z = 65;
camera_mount_x_offset_1 = 60;
camera_mount_x_offset_2 = camera_x - camera_mount_x_offset_1;
camera_mount_y_offset_1 = 10;
camera_mount_y_offset_2 = camera_y - camera_mount_y_offset_1;

light_width = 77;
camera_to_light_gap = 10;

strut_offset = light_width/4;
strut_x = camera_x + light_width + camera_to_light_gap - 2 * strut_offset;
strut_y = camera_y;
strut_z = 8;

groove_bottom_dia = 21.5;
groove_top_dia = 5;
groove_thickness = 3.4;
groove_length = 10;

mount_screw_hole = 8.25;

f = 0.01;
df = 2 * f;

$fn = 32;

module strut() {
    difference() {
        translate([strut_offset, 0, 0])
            box_with_round_edges_3d([strut_x, strut_y, strut_z], 5);
        hull() {
            translate([camera_mount_x_offset_1 + groove_length/2, camera_mount_y_offset_1, -f]) 
                cylinder(d = groove_top_dia, h = strut_z + df);
            translate([camera_mount_x_offset_1 - groove_length/2, camera_mount_y_offset_1, -f]) 
                cylinder(d = groove_top_dia, h = strut_z + df);

        }
        hull() {
            translate([camera_mount_x_offset_1 + groove_length/2, camera_mount_y_offset_1, -f])
                cylinder(d = groove_bottom_dia, h = strut_z - groove_thickness);            
            translate([camera_mount_x_offset_1 - groove_length/2, camera_mount_y_offset_1, -f])
                cylinder(d = groove_bottom_dia, h = strut_z - groove_thickness);            
        }
    }
    translate([camera_x + camera_to_light_gap - gopro_tripod_width/2 + light_width/2, strut_y/2, strut_z])
        rotate([-90, 0, -90])
            gopro_mount_tripod_side();
}

module camera_and_light() {
    translate([0, 0, strut_z])
        cube([camera_x, camera_y, camera_z]);
    translate([camera_x + camera_to_light_gap, 0, strut_z + 15])
        cube([light_width, camera_y, light_width]);
}
strut();
//#camera_and_light();