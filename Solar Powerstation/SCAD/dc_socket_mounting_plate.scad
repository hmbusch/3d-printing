include <../../Various/SCAD/rounded_box.scad>;

socket_dia = 11.2;
socket_offset_x = 20;
socket_offset_y = 42 - 26;

screw_hole_dia = 3.2;
screw_hole_offset = 5;

plate_x = 61;
plate_y = 42;
plate_thickness = 1.6;

f = 0.01;
df = f*2;

$fn = 64;

difference() {
    box_with_round_edges_3d([plate_x, plate_y, plate_thickness]);
    translate([socket_offset_x, socket_offset_y, -f])
        cylinder(d = socket_dia, h = plate_thickness + df);
    
    for (x = [screw_hole_offset, plate_x - screw_hole_offset]) {
        for (y = [screw_hole_offset, plate_y - screw_hole_offset]) {
            translate([x, y, -f])
                cylinder(d = screw_hole_dia, h = plate_thickness + df);            
        }
    }
}
