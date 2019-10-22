use <rounded_box.scad>;

$fn = 128;

vial_top = 20;
vial_bottom = 17;
vial_spacing = 1;
vial_slack = 0.1;
side_spacing = 2;

vial_rows = 3;
vial_cols = 3;

total_x = (vial_rows * vial_top) + ((vial_rows - 1) * vial_spacing + side_spacing * 2);
total_y = (vial_cols * vial_top) + ((vial_cols - 1) * vial_spacing + side_spacing * 2);
total_z = 16;

/**
 * Fudge is a minimal offset to achieve nicer preview rendering (e.g. without any 
 * moiree due to intersecting surfaces.
 */
fudge = 0.01;

slot_depth = total_z - 1.6;

module holder() {
    difference() {
        box_with_round_edges_3d([total_x, total_y, total_z], 3);
        
        translate([vial_top / 2 + side_spacing, vial_top / 2 + side_spacing, total_z - slot_depth]) {
            for(index_x = [0, 1, vial_rows - 1]) {
                for(index_y = [0, 1, vial_cols - 1]) {
                    translate([index_x * (vial_top + vial_spacing), index_y * (vial_top + vial_spacing), 0]) {
                        cylinder(d = vial_bottom + vial_slack, h = slot_depth + fudge);
                    }
                }
            }
        }
    }
}

/**
 * Renders a set of vial to fill the holder. For visualization purposes only.
 */
module vials() {
    translate([vial_top / 2 + side_spacing, vial_top / 2 + side_spacing, total_z - slot_depth]) {
        for(index_x = [0, 1, vial_rows - 1]) {
            for(index_y = [0, 1, vial_cols - 1]) {
                translate([index_x * (vial_top + vial_spacing), index_y * (vial_top + vial_spacing), fudge]) {
                    vial();
                }
            }
        }
    }
}

/**
 * Renders a single sample vial.
 */
module vial() {
    cylinder(d = vial_bottom, h = 60.5 - fudge);
    translate([0, 0, 60.5 - 14.5]) {
        cylinder(d = vial_top, h = 14.5);
    }
}

holder();
//#vials();