spacer_thickness = 1;
hole_circle = 12;
hole_offset = cos(45) * (hole_circle/2);

$fn = 64;

module spacer_body() {
    difference() {
        // outer ring
        cylinder(d = 17, h = spacer_thickness);
        cylinder(d = 7.5, h = spacer_thickness);
    }
}
    

module screw_holes() {
    translate([hole_offset, hole_offset, 0]) cylinder(d = 2.2, h = spacer_thickness, $fn = 32);
    translate([hole_offset, -hole_offset, 0]) cylinder(d = 2.2, h = spacer_thickness, $fn = 32);
    translate([-hole_offset, -hole_offset, 0]) cylinder(d = 2.2, h = spacer_thickness, $fn = 32);
    translate([-hole_offset, hole_offset, 0]) cylinder(d = 2.2, h = spacer_thickness, $fn = 32);
}

module weight_reduction_slot() {
    for (angle = [65:1:115]) { 
        translate([cos(angle) * hole_circle / 2, sin(angle) * hole_circle / 2, -0.1]) cylinder(d = 1.5 , h = spacer_thickness + 0.2, $fn = 32);
    }
}

module weight_reduction() {
    weight_reduction_slot();
    rotate([0, 0, 90]) weight_reduction_slot();
    rotate([0, 0, 180]) weight_reduction_slot();
    rotate([0, 0, 270]) weight_reduction_slot();
}

difference() {
    spacer_body();
    screw_holes();
    //weight_reduction();
}