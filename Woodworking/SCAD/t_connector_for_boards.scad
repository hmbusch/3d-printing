board_thickness = 15;
wall_strength = 2;

// Derived values, do not edit
bar_width = board_thickness + 2 * wall_strength;

difference() {
    union() {
        cube([6 * board_thickness, bar_width, board_thickness + wall_strength]);
        translate([(6 * board_thickness - bar_width)/2, 0, 0])
            cube([bar_width, 4 * board_thickness, board_thickness + wall_strength]);
        translate([0, board_thickness, 0])
            rotate([0, 0, -45])
                cube([bar_width/2, bar_width * 3, wall_strength]);
        translate([6 * board_thickness, 0, 0])
            mirror([1, 0, 0])
                translate([0, board_thickness, 0])
                    rotate([0, 0, -45])
                        cube([bar_width/2, bar_width * 3, wall_strength]);
    }
    translate([0, wall_strength, wall_strength]) {
        cube([6 * board_thickness, board_thickness, board_thickness]);
        translate([(6 * board_thickness - bar_width)/2 + wall_strength, 0, 0])
            cube([board_thickness, 5 * board_thickness, board_thickness]);
    }
    translate([3 * board_thickness, board_thickness/4, board_thickness/4])
        cube([1.5, board_thickness, board_thickness], center = true);
}