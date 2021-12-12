washer_cutout_depth = 3;
ring_height = 6;

_fudge = 0.01;
$fn = 64;

difference() {
    cylinder(d = 17, h = ring_height);
    translate([0,0,ring_height - washer_cutout_depth + _fudge]) cylinder(d = 15, h = washer_cutout_depth);
    translate([0,0,-_fudge])cylinder(d1= 4, d2 = 5, h = ring_height - washer_cutout_depth + 3 * _fudge);
    translate([5, -2, 3.5]) cube([20, 4, 4]);
}
