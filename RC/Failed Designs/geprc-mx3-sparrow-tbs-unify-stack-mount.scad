use <../Universal/SCAD/rounded_box.scad>;

$fn = 64;

baseplate_xy = 28;
baseplate_z = 1;

tbsunify_x = 32;
tbsunify_y = 23;
tbsunify_z = 1.5;

tbsunify_x_cage_clearance = 2.5;
tbsunify_block_z = 4.5;

bevel_thickness = 2.4;

// Render allowance for clean preview
ra = 0.01;

m2_hole = 2.2;
hole_spacing = 20;
hole_offset_1 = (baseplate_xy - hole_spacing) / 2;
hole_offset_2 = baseplate_xy - hole_offset_1;


module baseplate_20x20() {
    box_with_round_edges(width = baseplate_xy, depth = baseplate_xy, height = baseplate_z, edge_radius = 4);
}

module mounting_holes_20x20() {
    // mounting holes 20x20mm
    translate([hole_offset_1, hole_offset_1, -0.1]) cylinder(d = m2_hole, h = 10);
    translate([hole_offset_1, hole_offset_2, -0.1]) cylinder(d = m2_hole, h = 10);
    translate([hole_offset_2, hole_offset_1, -0.1]) cylinder(d = m2_hole, h = 10);
    translate([hole_offset_2, hole_offset_2, -0.1]) cylinder(d = m2_hole, h = 10);
}

module cable_routing() {
    translate([0.5, 2, 0]) cube([8, 30, tbsunify_block_z + ra]);
    translate([hole_offset_2 - 5, 0, 0]) cube([10, 30, tbsunify_block_z + ra]);
    translate([tbsunify_x + bevel_thickness - 10, (tbsunify_y + bevel_thickness) / 2 - 5, 0]) cube([10, 10,  tbsunify_block_z + ra]);
    
}

module tbsunify_cradle() {
    difference() {
        cube([tbsunify_x + bevel_thickness, tbsunify_y + bevel_thickness, tbsunify_block_z + baseplate_z]);
        translate([bevel_thickness / 2, bevel_thickness /2 , tbsunify_block_z - tbsunify_z]) cube([tbsunify_x, tbsunify_y, tbsunify_z + ra + baseplate_z]);
        translate([12.5, 0, baseplate_z]) cube([4, tbsunify_y + bevel_thickness + 2 * ra, 1.6]);
    }
}

difference() {
    union() {
        translate([0, 2, 0]) baseplate_20x20();
        translate([tbsunify_x_cage_clearance - (tbsunify_x + bevel_thickness - baseplate_xy) / 2, 0]) tbsunify_cradle();
    }
    translate([0, 2, 0]) mounting_holes_20x20();
    translate([0, -ra, baseplate_z]) cable_routing();
}