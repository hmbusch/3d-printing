washer_dia = 14;
washer_hole = 3.6;
washer_height = 5;

screw_head_dia = 7.1;
screw_head_height = 3;

$fn = 64;

difference() {
    cylinder(d = washer_dia, h = washer_height);
    cylinder(d = washer_hole, h = washer_height);
    translate([0, 0, washer_height - screw_head_height])
        cylinder(d2 = screw_head_dia, d1 = washer_hole, h = screw_head_height);
}