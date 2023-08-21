dim_x = 15.8;
dim_y = 8.2;
dim_z = 1;

wall = 0.4;

f = 0.01;
df = 2 * f;

hole_spacing = 20.5;
hole_dia = 2.6;

$fn = 64;

lip = 10;


difference() {
    union() {
        cube([dim_x + lip, dim_y + lip, wall]);
        translate([lip/2 - wall, lip/2 - wall, 0])
            cube([dim_x + 2 * wall, dim_y + 2 * wall, wall + dim_z]);
    }
    translate([lip/2, lip/2, -f])
        cube([dim_x, dim_y, dim_z + wall + df]);
    
    hole_x_offset = (dim_x + lip)/2 - hole_spacing/2;
    
    translate([hole_x_offset, (dim_y + lip)/2, -f])
        cylinder(d = hole_dia, h = wall + df);

    translate([dim_x + lip - hole_x_offset, (dim_y + lip)/2, -f])
        cylinder(d = hole_dia, h = wall + df);
    
}