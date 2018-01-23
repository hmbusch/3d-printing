/**
 * FrSky R-XSR 20x20mm stack mount
 *
 * by Hendrik Busch, 2018 (https://github.com/hmbusch)
 *
 * I needed to stack a R-XSR receiver onto a 20x20mm stack and
 * designed this plate for this purpose. The RX is held in place
 * by a ziptie and you can feed the cable from underneath through
 * the slot.
 */
use <rounded_box.scad>

$fn = 32;

x = 0;
y = 1;
z = 2;

dim_plate = [28, 28, 1];
dim_rx = [16.1, 11];
dim_ziptie = [4, 2];

hole_spacing = 20;
hole_offset_1 = (dim_plate[y] - hole_spacing) / 2;
hole_offset_2 = dim_plate[y] - hole_offset_1;
hole_diameter = 2.2;
bevel_height = 2.4;
bevel_width = 1;

difference() {
    union() {
         color("LightSlateGray")
         box_with_round_edges(width = dim_plate[x], depth = dim_plate[y], height = dim_plate[z], edge_radius = 4); 
        
        // bevels 
        color("Cornsilk") {
            bevel_offset_1 = ((dim_plate[y] - dim_rx[y])/2) - bevel_width;
            bevel_offset_2 = dim_plate[y] - bevel_offset_1 - bevel_width;
            translate([2, bevel_offset_1, dim_plate[z]]) cube([dim_rx[x], bevel_width, bevel_height]);
            translate([2, bevel_offset_2, dim_plate[z]]) cube([dim_rx[x], bevel_width, bevel_height]);
            hull() {
                translate([dim_rx[x] - 1, bevel_offset_2, dim_plate[z]]) cube([2, bevel_width, bevel_height]);
                translate([dim_rx[x] + 2, bevel_offset_2, dim_plate[z]]) cube([4, bevel_width, 2 * bevel_height]);
            }
            translate([2 - bevel_width, bevel_offset_2 + bevel_width - 4, 1]) cube([bevel_width, 4, bevel_height]);
            translate([dim_rx[x] + 2, bevel_offset_1, dim_plate[z]]) cube([bevel_width, 3, 2 * bevel_height]);
            hull() {
                translate([dim_rx[x] + 2, bevel_offset_1, dim_plate[z]]) cube([bevel_width, bevel_width, 2 * bevel_height]);
                translate([dim_rx[x], bevel_offset_1, dim_plate[z]]) cube([bevel_width, bevel_width, bevel_height]);
            }        
        }
    }
    
    color("LightSlateGray") {
        // mounting holes 20.5x20.5mm
        translate([hole_offset_1, hole_offset_1, -0.1]) cylinder(d = hole_diameter, h = dim_plate[z] + 0.2);
        translate([hole_offset_1, hole_offset_2, -0.1]) cylinder(d = hole_diameter, h = dim_plate[z] + 0.2);
        translate([hole_offset_2, hole_offset_1, -0.1]) cylinder(d = hole_diameter, h = dim_plate[z] + 0.2);
        translate([hole_offset_2, hole_offset_2, -0.1]) cylinder(d = hole_diameter, h = dim_plate[z] + 0.2);

        // zip-tie holes
        translate([8, 5, -0.1]) cube([dim_ziptie[x], dim_ziptie[y], dim_plate[z] + 0.2]);
        translate([8, 21, -0.1]) cube([dim_ziptie[x], dim_ziptie[y], dim_plate[z] + 0.2]);

        // weight reduction
        hull() {
            translate([7, 14, -0.1]) cylinder(d = 8, h = dim_plate[z] + 0.2);
            translate([15, 14, -0.1]) cylinder(d = 8, h = dim_plate[z] + 0.2);
        }
        hull() {
            translate([24.25, 9, -0.1]) cylinder(d = 3.2, h = dim_plate[z] + 0.2);
            translate([24.25, 19, -0.1]) cylinder(d = 3.2, h = dim_plate[z] + 0.2);
        }
    }       
}
