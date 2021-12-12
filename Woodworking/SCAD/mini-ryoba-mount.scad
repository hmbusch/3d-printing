// Wall mount for the Augusta Mini-Ryoba saw (150mm)

mounting_hole_x = 11;
mounting_hole_y = 18;
spacing_from_wall = 13;
offset = 1.5;

$fn = 64;

module mounting_peg_2d() {
    hull() {
        circle(d= mounting_hole_x);
        translate([0, mounting_hole_y - mounting_hole_x])
            circle(d = mounting_hole_x);
    }
}

module mounting_peg_complete() {
    linear_extrude(height = spacing_from_wall)
        offset(delta = -offset)
            mounting_peg_2d();
    hull() {
        translate([0, 0, spacing_from_wall])
            linear_extrude(height = 0.1)
                offset(delta = -offset)
                    mounting_peg_2d();
        translate([0, 0, spacing_from_wall + offset])
            linear_extrude(height = 1)
                    mounting_peg_2d();
    }
}

module screw() {
    rotate([0, 180, 0]) {
        cylinder(d=3.2, h=spacing_from_wall + 2 * offset);
        cylinder(d1=7.5, d2=3.2, h=3);
    }
}

difference() {
    mounting_peg_complete();
    translate([0, -offset/2, spacing_from_wall + offset + 1])
        screw();
    translate([0, mounting_hole_y - mounting_hole_x + offset/2, spacing_from_wall + offset + 1])
        screw();
}