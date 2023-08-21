dim_x = 98;
dim_y = 85;
dim_z = 2;

area_1_x = 11.5;
area_2_x = 14;

area_2_y = 6;

hole_dia = 3.1;
hole_y_offset = 10;

thickness = 2;

f = 0.01;
df = f * 2;

$fn = 64;

module screw_hole() {
    cylinder(d = hole_dia, h = thickness + df);
}

difference() {
    cube([dim_x, dim_y, dim_z]);
    for(y = [hole_y_offset, dim_y - hole_y_offset]) {
        for (x = [area_1_x/2, dim_x - area_1_x/2])  {
            translate([x, y, -f])
                screw_hole();
        }
    }
    translate([area_1_x + area_2_x, area_2_y, -f]) {
        cube([dim_x - 2 * area_1_x - 2 * area_2_x, dim_y - 2 * area_2_y, thickness + df]);
    }
}
    
