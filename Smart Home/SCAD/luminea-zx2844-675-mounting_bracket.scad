use <../../Various/SCAD/rounded_box.scad>

$fn = 64;
fudge = 0.01;

module_height = 20;
module_width = 39;

bracket_thickness = 4;
bracket_width = 10;

mounting_post_width = 10;

// Derived values, do not edit
pf = fudge;
nf = -fudge;

module mounting_post() {
    rotate([90, 0, 90]) {
        difference() { 
            box_with_round_edges_3d(
                dimensions = [mounting_post_width + bracket_thickness, bracket_width, bracket_thickness],
                edges = [true, false, true, false]);
            translate([mounting_post_width/2, bracket_width/2, 0]) {
                translate([0, 0, bracket_thickness/2 - bracket_thickness])
                    cylinder(d = 3.5, h = 2 * bracket_thickness);
                translate([0, 0, nf]) cylinder(d1 = 7, d2 = 3.5, h = 2);
            }
        }
    }
}

module bracket()  {
    difference() {
        box_with_round_edges_3d(
            dimensions = [module_height + bracket_thickness, module_width + 2 * bracket_thickness, bracket_width],
            edges = [true, false, true, false]);
        translate([bracket_thickness, bracket_thickness, bracket_width/2-bracket_width]) cube([module_height + pf, module_width, 2 * bracket_width]);
    }
}

module final_part() {
    bracket();
    translate([module_height, -mounting_post_width, 0])
        mounting_post();
    translate([module_height, module_width + 2 * bracket_thickness + mounting_post_width, bracket_width])
        rotate([180, 0, 0]) 
            mounting_post();
}

final_part();
    