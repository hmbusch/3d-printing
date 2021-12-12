washer_dia = 18;
washer_hole = 3.6;
washer_height = 11;

pin_dia = 5;
pin_height = 4;

screw_head_dia = 7.1;
screw_head_height = 3;

$fn = 64;

difference() {
    union() {        
        cylinder(d = washer_dia, h = washer_height);
        translate([0, 0, - pin_height])
            cylinder(d = pin_dia, h = pin_height);
    }
    translate([0, 0, - pin_height]) 
        cylinder(d = washer_hole, h = washer_height + pin_height);
    translate([0, 0, washer_height - screw_head_height])
        cylinder(d2 = screw_head_dia, d1 = washer_hole, h = screw_head_height);    
}