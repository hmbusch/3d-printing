include <../../Various/SCAD/rounded_box.scad>;
include <../../Various/SCAD/screw_holes.scad>;

outlet_hole_dia = 68.5;
outlet_cover_x = 111;
outlet_cover_y = 87;

rbpi3_case_x = 94;
rbpi3_case_y = 63;
rbpi3_hole_spacing = 55;
rbpi3_hole_dia = 3.2;
rbpi3_hole_x_offset = 15 + 12;

base_plate_margin = 10;
base_plate_x = max(outlet_cover_x, rbpi3_case_x) + 2 * base_plate_margin;
base_plate_y = outlet_cover_y + rbpi3_case_y + 2 * base_plate_margin;
base_plate_z = 6;

mounting_hole_positions_y = [5, 81, 117, 153];
mounting_hole_dia = 3.2;

m3_nut_width = 5.7;
m3_nut_height = 4.1;

text_extrusion_height = 1.4;

f = 0.01;
df = 2 * f;

$fn = 64;

module base_plate(flavor = "base", height = base_plate_z) {   
    difference() {
        // base plate
        box_with_round_edges_3d([base_plate_x, base_plate_y, height], 5);
        
        // socket cutout
        socket_x_offset = base_plate_margin + outlet_cover_x/2;
        socket_y_offset = base_plate_margin + outlet_cover_y/2;
        
        translate([socket_x_offset, socket_y_offset, -f]) 
            cylinder(d = outlet_hole_dia, h = height + df);
        
        // Add Raspberry Pi mounting holes to back plate
        if (flavor == "base") {
            
            rbpi3_x_offset = base_plate_margin + rbpi3_hole_x_offset + (outlet_cover_x - rbpi3_case_x)/2;
            rbpi3_y_offset = 2 * base_plate_margin + outlet_cover_y + rbpi3_case_y/2;
            
            translate([rbpi3_x_offset, rbpi3_y_offset, -f]) {
                cylinder(d = rbpi3_hole_dia, h = height + df);
                translate([0, 0, height - m3_nut_height + df])
                    nut_trap(rbpi3_hole_dia, m3_nut_width, 0, m3_nut_height);
            }
            translate([rbpi3_x_offset + rbpi3_hole_spacing, rbpi3_y_offset, -f]) {
                cylinder(d = rbpi3_hole_dia, h = height + df);
                translate([0, 0, height - m3_nut_height + df])
                    nut_trap(rbpi3_hole_dia, m3_nut_width, 0, m3_nut_height);
            }
        }
        
        // add label with ratings to counter plate
        if (flavor == "counter") {
            translate([base_plate_x * 0.7, base_plate_y * 0.75, height - text_extrusion_height +f]) {
                rotate([0, 0, 180])
                    rating_label();
            }
        }
        
        // mounting holes
        for(x = [base_plate_margin/2, base_plate_x - base_plate_margin/2]) {
            for(y = mounting_hole_positions_y) {
                translate([x, y, -f])
                    cylinder(d = mounting_hole_dia, h = height + df);
            }
        }
    }
}

module rating_label() {
    linear_extrude(height = text_extrusion_height)
        text("230V", 15, "CMU Sans Serif:style=Bold"); 
    translate([50, 1, 0])
        linear_extrude(height = text_extrusion_height)
            text("~", 15, "CMU Sans Serif:style=Bold", valign = "center"); 
    translate([-55/2, -25, 0])
        linear_extrude(height = text_extrusion_height)
            text("max. 400W", 15, "CMU Sans Serif:style=Bold"); 
}

base_plate();
translate([base_plate_x + 10, 0, 0])
    base_plate("counter", 3);
translate([base_plate_x + 10, -50, 0])
    scale([0.99, 0.99, 0.99])
        rating_label();

