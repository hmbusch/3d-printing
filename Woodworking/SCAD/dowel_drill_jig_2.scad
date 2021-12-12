sheet_thickness = 15;
wall_thickness = 2;
drill_dia = 8;
jig_length = 100;
drill_guide_height = 20;
positioning_guide_depth = 1;

drill_hole_spacing = jig_length / 4;
$fn = 64;

difference() {
    union() {
        difference() {
            cube([jig_length, sheet_thickness + 2 * wall_thickness, sheet_thickness + wall_thickness]); 
            translate([0, wall_thickness, 0])
                cube([jig_length, sheet_thickness + wall_thickness, sheet_thickness]);
            for(i = [1 : 1 : 3]) {
                translate([i * drill_hole_spacing - positioning_guide_depth/2, 0, 0]) {
                    translate([0, 0, sheet_thickness + wall_thickness - positioning_guide_depth])
                        cube([positioning_guide_depth, sheet_thickness + 2 * wall_thickness, positioning_guide_depth]);
                    cube([positioning_guide_depth, positioning_guide_depth/2, sheet_thickness + wall_thickness]);
                }
            }
            translate([0, sheet_thickness/2 + wall_thickness - positioning_guide_depth/2, sheet_thickness + wall_thickness - positioning_guide_depth]) 
                cube([jig_length, positioning_guide_depth, positioning_guide_depth]);
        }
        translate([0, sheet_thickness/2 + wall_thickness, sheet_thickness])
            for(i = [1 : 1 : 3]) {
                translate([i * drill_hole_spacing, 0, 0])
                    cylinder(d1 = drill_dia + 4 * wall_thickness, d2 = drill_dia + 2 * wall_thickness, h = drill_guide_height);
            }
    }
    translate([0, sheet_thickness/2 + wall_thickness, 0])
        for(i = [1 : 1 : 3]) {
                translate([i * drill_hole_spacing, 0, 0])
                    cylinder(d = drill_dia, h = drill_guide_height + sheet_thickness);
            }
}
