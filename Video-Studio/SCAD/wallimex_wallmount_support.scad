use <../../Various/SCAD/rounded_box.scad>

plate_x = 80;
plate_y = 120;

hole_spacing_1_x = 60;
hole_spacing_1_y = 100;
hole_dia_1 = 8;
screw_head_dia_1 = 9;
screw_head_height_1 = 3.5;

hole_spacing_2_x = 40;
hole_spacing_2_y = 90;
hole_dia_2 = 6;
screw_head_dia_2 = 9;
screw_head_height_2 = 3.5;

tube_dia = 23;

offset_1_x = (plate_x - hole_spacing_1_x)/2;
offset_1_y = (plate_y - hole_spacing_1_y)/2;

offset_2_x = (plate_x - hole_spacing_2_x)/2;
offset_2_y = (plate_y - hole_spacing_2_y)/2;

support_plate_thickness = 6;
support_length = 150;

f = 0.01;
df = 2 * f;

$fn = 64;

module baseplate() {
    color("silver")
    difference() {
        union() {
            box_with_round_edges_3d([plate_x, plate_y, 2], 8);
            translate([plate_x/2, plate_y/2, 2])
                cylinder(d = tube_dia, h = 200);
        }
        // large holes
        translate([offset_1_x, offset_1_y, -f])
            cylinder(d = hole_dia_1, h = 2 + df);
        translate([offset_1_x, offset_1_y + hole_spacing_1_y, -f])
            cylinder(d = hole_dia_1, h = 2 + df);
        translate([offset_1_x + hole_spacing_1_x, offset_1_y + hole_spacing_1_y, -f])
            cylinder(d = hole_dia_1, h = 2 + df);
        translate([offset_1_x + hole_spacing_1_x, offset_1_y, -f])
            cylinder(d = hole_dia_1, h = 2 + df);
        
        // small holes
        translate([offset_2_x, offset_2_y, -f])
            cylinder(d = hole_dia_2, h = 2 + df);
        translate([offset_2_x, offset_2_y + hole_spacing_2_y, -f])
            cylinder(d = hole_dia_2, h = 2 + df);
        translate([offset_2_x + hole_spacing_2_x, offset_2_y + hole_spacing_2_y, -f])
            cylinder(d = hole_dia_2, h = 2 + df);
        translate([offset_2_x + hole_spacing_2_x, offset_2_y, -f])
            cylinder(d = hole_dia_2, h = 2 + df);
    }
}

module support() {
    difference() {
        union() {
            difference() {
                box_with_round_edges_3d([plate_x, plate_y/2, support_plate_thickness], 8);
                translate([offset_1_x, offset_1_y, -f]) {
                    cylinder(d = hole_dia_1, h = support_plate_thickness + df);
                    translate([0, 0, support_plate_thickness - screw_head_height_1 + df])
                        cylinder(d1 = hole_dia_1, d2 = screw_head_dia_1, h = screw_head_height_1 + f); 
                }
                translate([offset_1_x + hole_spacing_1_x, offset_1_y, -f]) {
                    cylinder(d = hole_dia_1, h = support_plate_thickness + df);        
                    translate([0, 0, support_plate_thickness - screw_head_height_1 + df])
                        cylinder(d1 = hole_dia_1, d2 = screw_head_dia_1, h = screw_head_height_1 + f); 
                }
                translate([offset_2_x, offset_2_y, -f]) {
                    cylinder(d = hole_dia_2, h = support_plate_thickness + df);
                    translate([0, 0, support_plate_thickness - screw_head_height_1 + df])
                        cylinder(d1 = hole_dia_2, d2 = screw_head_dia_2, h = screw_head_height_2 + f); 
                }
                translate([offset_2_x + hole_spacing_2_x, offset_2_y, -f]) {
                    translate([0, 0, support_plate_thickness - screw_head_height_1 + df])
                        cylinder(d1 = hole_dia_2, d2 = screw_head_dia_2, h = screw_head_height_2 + f); 
                    cylinder(d = hole_dia_2, h = support_plate_thickness + df);
                }
            }
        
            hull() {
                difference() {
                    translate([plate_x/2, plate_y/2, 0]) 
                        cylinder(d = 2 * tube_dia, h = support_plate_thickness);    
                    translate([plate_x/2 - tube_dia, plate_y/2, - f])
                        cube([2 * tube_dia, 2 * tube_dia, 2 * support_plate_thickness + df]);
                }

                difference() {
                    translate([plate_x/2, plate_y/2, support_length]) 
                        cylinder(d = 2 * tube_dia, h = 2 * support_plate_thickness);    
                    translate([plate_x/2 - tube_dia, plate_y/2, support_length - f])
                        cube([2 * tube_dia, 2 * tube_dia, 2 * support_plate_thickness + df]);
                }
            }
            
            difference() {
                hull() {
                    translate([plate_x/2 - support_plate_thickness, 0, 0])
                        cube([2 * support_plate_thickness, plate_y/2, support_plate_thickness * 2]);
                    translate([plate_x/2 - support_plate_thickness, plate_y/2 - tube_dia - 1, support_length])
                        cube([2 * support_plate_thickness, 2 * support_plate_thickness, support_plate_thickness * 2]);
                }
                translate([plate_x/2 - support_plate_thickness - f, plate_y/2 - tube_dia - 20/2 - 5, support_plate_thickness + 20/2 + 5])
                    rotate([0, 90, 0])
                        cylinder(d = 20, h = 2 * support_plate_thickness + df);
                translate([plate_x/2 - support_plate_thickness - f, plate_y/2 - tube_dia - 15/2 - 5, support_plate_thickness + 40])
                    rotate([0, 90, 0])
                        cylinder(d = 15, h = 2 * support_plate_thickness + df);
                translate([plate_x/2 - support_plate_thickness - f, plate_y/2 - tube_dia - 10/2 - 5, support_plate_thickness + 65])
                    rotate([0, 90, 0])
                        cylinder(d = 10, h = 2 * support_plate_thickness + df);
                translate([plate_x/2 - support_plate_thickness - f, plate_y/2 - tube_dia - 5/2 - 5, support_plate_thickness + 85])
                    rotate([0, 90, 0])
                        cylinder(d = 5, h = 2 * support_plate_thickness + df);
            }
            

        }
        translate([plate_x/2, plate_y/2, -f]) 
            cylinder(d = tube_dia, h = support_length + 2 * support_plate_thickness + df);    
        translate([plate_x/2 - 5, plate_y/2 - tube_dia/2 - 2, -f]) 
            cube([10, 4, 25]);
    }

}

//translate([0, 0, -2])
//    #baseplate();
support();