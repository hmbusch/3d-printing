// COB width
cob_x = 72;
// COB length
cob_y = 62;
// Bottom cover length
cob_b_cover_y = 15;
// Side cover width
cob_s_cover_x = 22;

screw_post_dia = 6;
screw_hole_dia = 3.2;

plate_z = 1;
plate_distance = 2.5;
rim_x = plate_z;
rim_y = plate_z;

rim_z = plate_z + plate_distance;

f = 0.01;
df = 2 * f;

$fn = 32;

difference() {
    union() {
        // Bottom Cover
        cube([cob_x, cob_b_cover_y, plate_z]);
        cube([12, 1, rim_z]);
        translate([22, 0, 0])
            cube([cob_x - 22, rim_y, rim_z]);
        translate([0, cob_b_cover_y, 0])
            cube([cob_x - cob_s_cover_x, rim_y, rim_z]);
        cube([rim_x, cob_b_cover_y, rim_z]);

        // Side Cover
        translate([cob_x - cob_s_cover_x, 0, 0])
            cube([cob_s_cover_x, cob_y, plate_z]);
        translate([cob_x - rim_x, 0, 0])
            cube([rim_x, cob_y, rim_z]);
        translate([cob_x - cob_s_cover_x, cob_b_cover_y, 0])
            cube([rim_x, cob_y - cob_b_cover_y, rim_z]);
        translate([cob_x - cob_s_cover_x, cob_y - rim_y, 0])
            cube([cob_s_cover_x, rim_y, rim_z]);
            
        // Screw Posts
        translate([3, 9, 0]) {
            cylinder(d = screw_post_dia, h = rim_z);
            translate([50, 0, 0])
                cylinder(d = screw_post_dia, h = rim_z);
            translate([50, 50, 0])
                cylinder(d = screw_post_dia, h = rim_z);
        }
    }
    translate([3, 9, -f]) {
        cylinder(d = screw_hole_dia, h = rim_z + df);
        translate([50, 0, 0])
            cylinder(d = screw_hole_dia, h = rim_z + df);
        translate([50, 50, 0])
            cylinder(d = screw_hole_dia, h = rim_z + df);
    }
}