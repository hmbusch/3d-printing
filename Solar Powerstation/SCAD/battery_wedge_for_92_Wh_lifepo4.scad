include <../../Various/SCAD/screw_holes.scad>;

wedge_length = 50;
wedge_width = 15;
wedge_height = 10;

nut_inset_depth = 5;
nut_width = 8.1;
screw_diameter = 5.1;

f = 0.01;
df = 2 * f;

$fn = 128;

module wedge() {
    difference() {
        cube([wedge_length, wedge_width, wedge_height]);
        for(i = [0:3]) {
            x_offset = 7 + i * (wedge_length - 14) / 3;
            translate([x_offset, wedge_width / 2, -f])
                cylinder(d = screw_diameter, h = wedge_height + df);
            translate([x_offset, wedge_width / 2, 0])
                nut_trap(screw_diameter, nut_width, wedge_height - nut_inset_depth + f, nut_inset_depth);
        }
    }   
}

wedge();
