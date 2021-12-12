use <../../Various/SCAD/rounded_box.scad>

bar_width = 20;
bar_height = 8;

bar_distance = 50;
bar_height_offset = 10;

bar_slack = 0.1;
bar_inset_depth = 15;

relief_hole_dia = bar_height/2;

bottom_spacing = 10;

part_strength = 6;

mounting_screw_hole = 3.7;
mounting_screw_hole_height = 4;
mounting_screw_head_hole = 7.2;
mounting_screw_head_height = 2.8;
mounting_screw_count = 3;
mounting_screw_initial_offset = 10;

f = 0.01;
df = 2 * f;
sacrificial_layer_thickness = 0.3;

$fn = 128;

// assembly values, required for cover
distance_between_mounts = 117.35;
cover_thickness = 1.5;
cover_z_offset = 5;

// derived values, do not edit
dim_y = 2 * bar_width + bar_distance + 2 * part_strength;
dim_x = bar_inset_depth + part_strength;
dim_z = bottom_spacing + bar_height + bar_height_offset + bar_height + part_strength;
dim_z_lower = bottom_spacing + bar_height + part_strength;
mounting_screw_spacing = (dim_y - 2 * mounting_screw_initial_offset) / (mounting_screw_count - 1);
screw_mount_x = dim_x + mounting_screw_head_hole + part_strength;

cover_scale = 1.01;
cover_x = 2 * screw_mount_x + distance_between_mounts + 2 * cover_thickness;
cover_y = dim_y + 2 * cover_thickness;
cover_z = dim_z + cover_thickness + cover_z_offset;

module bus_bar() {
    color("silver")
        cube([bar_inset_depth * 2, bar_width + bar_slack * 4, bar_height + bar_slack * 2]);
}

module block() {
    cube([dim_x, dim_y, dim_z_lower]);
    dim_y_upper = bar_width + 2 * part_strength;
    translate([0, dim_y - dim_y_upper, 0])
        cube([dim_x, bar_width + 2 * part_strength, dim_z]);
}

module screw_mount_body() {
    hull() {
        cube([dim_x, dim_y, dim_z_lower/2]);
        translate([dim_x - screw_mount_x, 0, 0])
            box_with_round_edges_3d([screw_mount_x, dim_y, dim_z_lower/4]);
    }
}

module screw_cutout(height) {
    union() {
        // screw thread sized hole
        translate([0, 0, -f]) 
            cylinder(d = mounting_screw_hole, h = height + df);
        // tapered hole for screw head
        translate([0, 0, mounting_screw_hole_height])
            cylinder(d1 = mounting_screw_hole, d2 = mounting_screw_head_hole, h = mounting_screw_head_height);
        // wide cutout for screw_head
        translate([0, 0, mounting_screw_hole_height + mounting_screw_head_height])
            cylinder(d = mounting_screw_head_hole, h = height);
    }
}


module screw_mount() {
    difference() {
        screw_mount_body();
        for(offset = [mounting_screw_initial_offset : mounting_screw_spacing : dim_y -  mounting_screw_initial_offset]) {
            translate([(dim_x - screw_mount_x) / 2, offset, 0])
                screw_cutout(dim_z_lower);
        }
    }
}

module mounting_block_body() {
    block();
    screw_mount_body();
}

module mounting_block() {
    difference() {
        // block body
        union() {
            block();
            screw_mount();
        }
        
        // bus bar cutouts
        translate([dim_x - bar_inset_depth, part_strength, bottom_spacing])
            bus_bar();
        translate([dim_x - bar_inset_depth, dim_y - part_strength - bar_width, dim_z - bar_height - part_strength])
            bus_bar();    
    
        // bus bar relief holes (for fitting)
        translate([part_strength - sacrificial_layer_thickness, part_strength + bar_width / 2, bottom_spacing + bar_height / 2])
            rotate([0, -90, 0])
                cylinder(d = relief_hole_dia, h = part_strength * 2);
        translate([part_strength - sacrificial_layer_thickness, dim_y - part_strength - bar_width/2, dim_z - part_strength - bar_height / 2])
            rotate([0, -90, 0])
                cylinder(d = relief_hole_dia, h = part_strength * 2);
    }
    
}

module mounting_block_assembly() {
    mounting_block();
    translate([2 * dim_x + distance_between_mounts, 0, 0])
    mirror([-1, 0, 0])
        mounting_block();
}

module mounting_block_body_assembly() {
    translate([screw_mount_x - dim_x, 0, 0])
    mounting_block_body();
    translate([screw_mount_x - dim_x + 2 * dim_x + distance_between_mounts, 0, 0])
        mirror([-1, 0, 0])
            mounting_block_body();
}

module cover() {
    difference() {
        // base body
        cube([cover_x, cover_y, cover_z]);
        
        // remove the mounting block assembly
        translate([cover_thickness, cover_thickness, 0])
                mounting_block_body_assembly();
        
        // remove the complete inner part and front / back walls in the middle
        translate([cover_thickness + screw_mount_x, 0, 0])
            cube([distance_between_mounts+0.1, dim_y + 2 * cover_thickness, dim_z - cover_thickness]);

        // save some material inside
        translate([cover_thickness + screw_mount_x, cover_thickness, 0])
            cube([distance_between_mounts+0.1, dim_y, cover_z - cover_thickness]);
        
        // remove excess right
        translate([0, 0, dim_z_lower/2 + cover_thickness])
            cube([screw_mount_x - dim_x, cover_y, cover_z - dim_z_lower/2]);
        // remove excess left
        translate([cover_x - (screw_mount_x - dim_x), 0, dim_z_lower/2 + cover_thickness])
            cube([screw_mount_x - dim_x, cover_y, cover_z - dim_z_lower/2]);        
        
        // add screw holes over middle screw holes of mounting block
        translate([(screw_mount_x - dim_x)/2, mounting_screw_initial_offset + mounting_screw_spacing, dim_z_lower/4])
            screw_cutout(dim_z_lower/2);
        translate([cover_x - (screw_mount_x - dim_x)/2, mounting_screw_initial_offset + mounting_screw_spacing, dim_z_lower/4])
            screw_cutout(dim_z_lower/2);            
    }
}

mounting_block_assembly();
translate([0, -1.5 * dim_y, 0])     
    scale([cover_scale, cover_scale, 1])
        cover();

