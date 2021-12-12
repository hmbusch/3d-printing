block_x = 51.5;
block_y = 27.5;

hole_spacing_x = 41;
hole_spacing_y = 15.2;
hole_dia = 4.2;

spacer_z = 4.8;

f = 0.01;
df = 2 * f;
$fn = 64;

// derived_values
hole_offset_x = (block_x - hole_spacing_x) / 2;
hole_offset_y = (block_y - hole_spacing_y) / 2;

difference() {
    cube([block_x, block_y, spacer_z]);
    translate([hole_offset_x, block_y - hole_offset_y, -f])
        cylinder(d = hole_dia, h = spacer_z + df);
    translate([block_x - hole_offset_x, hole_offset_y, -f])
        cylinder(d = hole_dia, h = spacer_z + df);
}