board_x = 110;
board_y = 85;
board_spacing = 5;
hole_offset = 4;
hole_diameter = 3.6;
strut_thickness = 5;
standoff_height = 3;
slack = 0.01;

extrusion_width = 20;
extrusion_slot = 4.8;
extrusion_slot_depth = 1.5;
extrusion_hole_diameter = 6;

$fn = 32;

module standoff(height = strut_thickness + standoff_height) {
    difference() {
        cylinder(d = 2 * hole_offset, h = height);
        translate([0, 0, -slack]) cylinder(d = hole_diameter, h = height + 2 * slack);
    }
}

module standoff_cube(height = strut_thickness + standoff_height) {
    difference() {
        translate([0, 0, height/2]) cube(size = [2 * hole_offset, 2 * hole_offset, height], center = true);
        translate([0, 0, -slack]) cylinder(d = hole_diameter, h = height + 2 * slack);
    }
}
    
module base_plate() {
    difference() {
        union() {
            // lower x-strut
            hull() {
                translate([hole_offset, hole_offset, 0]) standoff(height = strut_thickness);
                translate([board_x - hole_offset, hole_offset, 0]) standoff(height = strut_thickness);
            }
            
            // upper x-strut & spacer
            hull() {
                translate([hole_offset, board_y - hole_offset, 0]) standoff_cube(height = strut_thickness);
                translate([board_x - hole_offset, board_y - hole_offset, 0]) standoff_cube(height = strut_thickness);
                translate([0, board_y + strut_thickness, 0]) cube([1, board_spacing, strut_thickness]);
                translate([board_x - 1, board_y + strut_thickness, 0]) cube([1, board_spacing, strut_thickness]);
            }
            
            // left y-strut
            hull() {
                translate([hole_offset, hole_offset, 0]) standoff(height = strut_thickness);
                translate([hole_offset, board_y - hole_offset, 0]) standoff(height = strut_thickness);
            }

            // right y-strut
            hull() {
                translate([board_x - hole_offset, hole_offset, 0]) standoff(height = strut_thickness);
                translate([board_x - hole_offset, board_y - hole_offset, 0]) standoff(height = strut_thickness);
            }
            
            // bottom-left to top-right crossbrace
            hull() {
                translate([hole_offset, hole_offset, 0]) standoff(height = strut_thickness);
                translate([board_x - hole_offset, board_y - hole_offset, 0]) standoff(height = strut_thickness);
            }
            
            // top-left to bottom-right crossbrace
            hull() {
                translate([hole_offset, board_y - hole_offset, 0]) standoff(height = strut_thickness);
                translate([board_x - hole_offset, hole_offset, 0]) standoff(height = strut_thickness);
            }
        }
        
        // mounting holes
        translate([hole_offset, hole_offset, -slack]) cylinder(d = hole_diameter, h = strut_thickness + 2 * slack);
        translate([board_x - hole_offset, hole_offset, -slack]) cylinder(d = hole_diameter, h = strut_thickness + 2 * slack);
        translate([hole_offset, board_y - hole_offset, -slack]) cylinder(d = hole_diameter, h = strut_thickness + 2 * slack);
        translate([board_x - hole_offset, board_y - hole_offset, -slack]) cylinder(d = hole_diameter, h = strut_thickness + 2 * slack);
    }
}

module extrusion_rail() {
    slot_offset = (extrusion_width - extrusion_slot) / 2;
    hole_offset = extrusion_width / 2;
    hole_spacing = board_x / 5;

    difference() {
        union() {
            // rail & slot
            cube([board_x, extrusion_width, strut_thickness]);
            translate([0, slot_offset, strut_thickness]) cube([board_x, extrusion_slot, extrusion_slot_depth]);
        }
        // screw holes
        for(i = [0:4]) {
            translate([(hole_spacing / 2) + i * hole_spacing, hole_offset, -slack]) cylinder(d = extrusion_hole_diameter, h = strut_thickness + extrusion_slot_depth + 2 * slack);
        }
    }
}

module makerbase_sbase_mount() {
    base_plate();
    
    // raised standoffs
    translate([hole_offset, hole_offset, 0]) standoff();
    translate([hole_offset, board_y - hole_offset, 0]) standoff();
    translate([board_x - hole_offset, board_y - hole_offset, 0]) standoff();
    translate([board_x - hole_offset, hole_offset, 0]) standoff();
    
    // attach the rail (and sink it into the base_plate slightly, otherwise the resulting object
    // is not manifold and may cause problems)
    translate([0, board_y + board_spacing, extrusion_width + strut_thickness - slack]) rotate([-90, 0, 0]) extrusion_rail();
}

makerbase_sbase_mount();