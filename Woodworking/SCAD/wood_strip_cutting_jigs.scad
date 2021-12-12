$fn = 64;
thickness = 8;

width_1 = 26.8 - 2;
width_2 = width_1 - 2;
length = 150;
brim_side = 32;
brim_top = 15;

f = 0.01;
df = 2 * f;

clamp_hole_distance_x = 14;
clamp_hole_distance_y = 15;

module screw() {
    cylinder(d = 3.2, h = thickness);
    translate([0, 0, thickness-2])
        cylinder(d1 = 3.2, d2 = 7, h = 2 + df);
}

module clamp_hole_pattern() {
    translate([-clamp_hole_distance_x/2, -clamp_hole_distance_y/2, 0])
        cylinder(d = 3.2, h = thickness + df);
    translate([clamp_hole_distance_x/2, -clamp_hole_distance_y/2, 0])
        cylinder(d = 3.2, h = thickness + df);
    translate([-clamp_hole_distance_x/2, clamp_hole_distance_y/2, 0])
        cylinder(d = 3.2, h = thickness + df);
    translate([clamp_hole_distance_x/2, clamp_hole_distance_y/2, 0])
        cylinder(d = 3.2, h = thickness + df);
}

module jig(base_width, label) {
    difference() {
        cube([base_width + brim_side, length + 2 * brim_top, thickness]);
        translate([-f, brim_top, -f])
                cube([base_width + f, length, thickness + df]);
        translate([base_width/3, brim_top/2, -f])
            screw();
        translate([base_width/3, brim_top + length + brim_top/2, -f])
            screw();
        translate([base_width + brim_side - base_width/3, brim_top/2, -f])
            screw();
        translate([base_width + brim_side - base_width/3, brim_top + length + brim_top/2, -f])
            screw();
        translate([base_width + brim_side/2, (length + 2 * brim_top) / 2, -f])
            screw();
        translate([base_width + brim_side/2, (length + 2 * brim_top)/4, -f])
            clamp_hole_pattern();
        translate([base_width + brim_side/2, (length + 2 * brim_top)/4 * 3, -f])
            clamp_hole_pattern();
        translate([base_width + brim_side/4
, (length + 2 * brim_top)/3, thickness - 1])
            linear_extrude(height = 1+f) {
                text(text = label, font = "Consolas:style=Regular", size = 20);
            }
    }
}

jig(width_1, "1");

translate([3 * brim_side, 0, 0])
    jig(width_2, "2");