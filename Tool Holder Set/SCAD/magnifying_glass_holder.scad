use <../../Various/SCAD/rounded_box.scad>

$fn = 64;

handle_depth = 27;
handle_width = 32;
slack = 0.01;
holder_strength_height = 10;
holder_strength_width = 5;
tool_hole_dia = 7;

difference() {
    linear_extrude(height = holder_strength_height) {
        offset(r = holder_strength_width) {
            box_with_round_edges_2d(width = handle_width, depth = handle_depth);
        }
    }
    
    translate([0, 0, -slack]) linear_extrude(height = holder_strength_height + 2 * slack) {
        box_with_round_edges_2d(width = handle_width, depth = handle_depth);
    }
    
    translate([handle_width - 1.1 * holder_strength_width, 0, holder_strength_height / 2]) {
        translate([0, slack, 0]) screw();
        translate([0, 1.2 * holder_strength_width + handle_depth, 0]) rotate([90, 0, 0]) cylinder(d = tool_hole_dia, h = 2 * holder_strength_width);
    }
    translate([1.1 * holder_strength_width, 0, holder_strength_height / 2]) {
        translate([0, slack, 0]) screw();
        translate([0, 1.2 * holder_strength_width + handle_depth, 0]) rotate([90, 0, 0]) cylinder(d = tool_hole_dia, h = 2 * holder_strength_width);
    }
}


module screw() {
    rotate([90, 0, 0]) cylinder(d=4.2, h=10);
    rotate([90, 0, 0]) cylinder(d1=7.5, d2=4, h=3);
}

