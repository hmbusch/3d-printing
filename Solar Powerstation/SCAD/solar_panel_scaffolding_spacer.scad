width = 40;
depth = 40;
height = 3;
hole_diameter = 8.2;

$fn = 64;
f = 0.01;
df = 2 * f;

difference() {
    cube([width, depth, height]);
    translate([width/2, depth/2, -f])
        cylinder(d = hole_diameter, h = height + df);
}
