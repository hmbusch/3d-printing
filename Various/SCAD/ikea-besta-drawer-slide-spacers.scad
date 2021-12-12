$fn = 64;

base_height = 3;
base_thickness = 10;
base_offset = 10;
spacer_height = 22.6;
mounting_hole_dia_1 = 5.9;
mounting_hole_dia_2 = 7.5;
mounting_hole_dia_slide = 5.8;

module spacer() {
    difference() {
        union() {
            hull() {
                cylinder(d = base_thickness, h = base_height);
                translate([0, 40, 0])
                    cylinder(d = base_thickness, h = base_height);
            }
            
            hull() {
                cylinder(d = base_thickness, h = base_height);
                translate([base_offset, 0, 0])
                    cylinder(d = base_thickness, h = base_height);
            }

            hull() {
                translate([base_offset, 0, 0])
                    cylinder(d = base_thickness, h = base_height);
                translate([25, 20, 0])
                    cylinder(d = base_thickness, h = spacer_height);
            }

            hull() {
                translate([0, 40, 0])
                    cylinder(d = base_thickness, h = base_height);
                translate([base_offset, 40, 0])
                    cylinder(d = base_thickness, h = base_height);
            }

            hull()  {
                translate([base_offset, 40, 0])
                    cylinder(d = base_thickness, h = base_height);
                translate([25, 20, 0])
                    cylinder(d = base_thickness, h = spacer_height);
            }
        }
        cylinder(d = mounting_hole_dia_1, h = base_height);
        translate([0, 0, base_height - 1])
            cylinder(d2 = mounting_hole_dia_2, d1=mounting_hole_dia_1, h = 1);
        translate([0, 40, 0])
            cylinder(d = mounting_hole_dia_1, h = base_height);
        translate([0, 40, base_height - 1])
            cylinder(d2 = mounting_hole_dia_2, d1=mounting_hole_dia_1, h = 1);
        translate([25, 20, 0])
            cylinder(d = mounting_hole_dia_slide, h = spacer_height);
        translate([25, 20, spacer_height - 1])
            cylinder(d1 = mounting_hole_dia_slide, d2= mounting_hole_dia_slide + 1, h = 1);
    }
}

spacer();