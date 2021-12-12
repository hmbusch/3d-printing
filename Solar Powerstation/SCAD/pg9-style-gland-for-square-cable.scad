/*
 * PG9 Style Cable Gland for square Cable
 *
 * Initially designed for Sommer Cable Tribun 240 Speaker Wire,
 * to be filled with resin for water tightness.
 */
 
tube_diameter = 15.8;
tube_lip = 3;
tube_lip_height = 2;
tube_height = 25;
tube_inner_height = 15;
cable_width = 17.5/2;
cable_height = 3;
wall_thickness = 3;

sacrificial_layer_thickness = 0.2;

f = 0.01;
df = 2 * f;

$fn = 64;

difference() {
    union() {
        cylinder(d = tube_diameter, h = tube_height);
        cylinder(d = tube_diameter + 2 * tube_lip, h = tube_lip_height);
    }
    translate([-cable_width/2, -cable_height/2, tube_inner_height + sacrificial_layer_thickness])
        cube([cable_width, cable_height, tube_height - tube_inner_height]);
    translate([0, 0, -f])
        cylinder(d = tube_diameter - 2 * wall_thickness, h = tube_inner_height + f); 
}