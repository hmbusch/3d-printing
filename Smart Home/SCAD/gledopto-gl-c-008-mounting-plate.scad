use <../../Various/SCAD/rounded_box.scad>
use <../../Various/SCAD/screw_holes.scad>

// Plate for mounting a GLEDOPTO GL-C-008 RGB+CCT controller using
// two brackets from http://www.thingiverse.com/thing:3498167

$fn = 64;

outer_x = 93;
outer_y = 82;
outer_z = 3.6;

inner_y = 49;

beam_x = 15;

nut_height = 2.4;
nut_size = 5.5;

difference() {
    union() {
        box_with_round_edges_3d(dimensions = [beam_x, outer_y, outer_z]);
        translate([outer_x - beam_x, 0, 0]) 
            box_with_round_edges_3d(dimensions = [beam_x, outer_y, outer_z]);
        translate([0, (outer_y - inner_y) / 2, 0]) 
            box_with_round_edges_3d(dimensions = [outer_x, inner_y, outer_z]);
    }
    translate([beam_x/2, beam_x/2, outer_z + nut_height])
        rotate([180, 0, 0])
            nut_trap(height_shaft = outer_z, height_trap = nut_height, size_head = nut_size);
    translate([outer_x - beam_x/2, beam_x/2, outer_z + nut_height])
        rotate([180, 0, 0])
            nut_trap(height_shaft = outer_z, height_trap = nut_height, size_head = nut_size);
    translate([beam_x/2, outer_y - beam_x/2, outer_z + nut_height])
        rotate([180, 0, 0])
            nut_trap(height_shaft = outer_z, height_trap = nut_height, size_head = nut_size);
    translate([outer_x - beam_x/2, outer_y - beam_x/2, outer_z + nut_height])
        rotate([180, 0, 0])
            nut_trap(height_shaft = outer_z, height_trap = nut_height, size_head = nut_size);
    
    
}