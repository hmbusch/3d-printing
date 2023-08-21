use <../../Various/SCAD/rounded_box.scad>

strut_thickness = 6;

lamp_x = 77;
lamp_y = 26.5;
lamp_z = lamp_x;
lamp_bevel = 6;

usb_size_x = 12;
usb_size_y = 5;
usb_size_z = 7.5;

usb_pos_x = lamp_x/2 - usb_size_x/2;
usb_pos_y = lamp_y;
usb_pos_z = 56 - usb_size_z/2;

knob_dia = 20;
knob_dia_2 = 13;
knob_protrusion = 2;

screw_hole_dia = 3.2;
screw_hole_tap_dia = 2.5;
screw_head_dia = 6.2;

barndoor_gap = 2;

f = 0.01;
df = 2 * f;
$fn = 64;

// Derived values, do not edit
top_hinge_spacing = lamp_x - 2 * knob_dia;
side_hinge_spacing = lamp_z - lamp_z/5 - lamp_z/4 - 1 + strut_thickness;
bottom_hinge_spacing = lamp_x - 2 * lamp_x/5 + strut_thickness;

screw_strut_dia = strut_thickness * 1.5;

barndoor_size = lamp_x - barndoor_gap;
barndoor_thickness = 1.2;

module front_bracket() {
    translate([-strut_thickness/2, -strut_thickness, 0]) {
        cube([strut_thickness, strut_thickness, strut_thickness + lamp_bevel]);
        translate([0, strut_thickness, 0])
            cube([strut_thickness, lamp_y, strut_thickness]);
    }
}

module cage() {
    color("CornflowerBlue")
        difference() {
            union() {
                // bottom brackets
                translate([lamp_x/5, 0, 0])
                    front_bracket();
                translate([lamp_x - lamp_x/5, 0, 0])
                    front_bracket();
                
                // left brackets
                translate([-strut_thickness, 0, 0]) {
                    translate([0, 0, lamp_z/5 + strut_thickness/2])
                        rotate([0, 90, 0])
                            front_bracket();
                    // place top bracket a little bit lower to allow access to knobs
                    translate([0, 0, lamp_z - lamp_z/4 + strut_thickness/2 - 1])
                        rotate([0, 90, 0])
                            front_bracket();
                }

                // right brackets
                translate([lamp_x + strut_thickness, 0, 0]) {
                    translate([0, 0, lamp_z/5 + strut_thickness/2])
                        rotate([0, -90, 0])
                            front_bracket();
                    // place top bracket a little bit lower to allow access to knobs
                    translate([0, 0, lamp_z - lamp_z/4 + strut_thickness/2 - 1])
                        rotate([0, -90, 0])
                            front_bracket();
                }    
                
                // back struts
                
                // bottom
                translate([-strut_thickness, lamp_y, 0])
                    cube([lamp_x + 2 * strut_thickness, strut_thickness, 2 * strut_thickness]);
                // left
                translate([-strut_thickness, lamp_y, 0])
                    cube([2 * strut_thickness, strut_thickness, lamp_z - lamp_z/4 -1 + strut_thickness]);
                // right
                translate([lamp_x - strut_thickness, lamp_y, 0])
                    cube([2 * strut_thickness, strut_thickness, lamp_z - lamp_z/4 - 1 + strut_thickness]);
                // top connector struts
                difference() {
                    union() {
                        translate([-strut_thickness, lamp_y/3, lamp_z - lamp_z/4])
                            cube([strut_thickness, strut_thickness, lamp_z/4 + 2 * strut_thickness]);
                        translate([lamp_x, lamp_y/3, lamp_z - lamp_z/4])
                            cube([strut_thickness, strut_thickness, lamp_z/4 + 2 * strut_thickness]);
                        // add some strength around screw holes
                        translate([-strut_thickness, lamp_y/3 + strut_thickness/2, lamp_z + screw_strut_dia])
                            rotate([0, 90, 0])
                                cylinder(d = screw_strut_dia, h = strut_thickness);
                        translate([lamp_x, lamp_y/3 + strut_thickness/2, lamp_z + screw_strut_dia])
                            rotate([0, 90, 0])
                                cylinder(d = screw_strut_dia, h = strut_thickness);
                    }
                    // holes for screws
                    translate([-f - strut_thickness, lamp_y/3 + strut_thickness/2, lamp_z + screw_strut_dia])
                        rotate([0, 90, 0])
                            cylinder(d = screw_hole_dia, h = lamp_x + 2 * strut_thickness + df);
                }
                // back reinforcement strut
                translate([0, lamp_y, 3 * lamp_z/5])
                    cube([lamp_x, strut_thickness, strut_thickness]);
                
                // barndoor mounts
                translate([(lamp_bevel - strut_thickness)/2, - strut_thickness, lamp_z/5]) 
                    cylinder(d = screw_strut_dia, h = side_hinge_spacing);    
                translate([lamp_x - (lamp_bevel - strut_thickness)/2, - strut_thickness, lamp_z/5])
                    cylinder(d = screw_strut_dia, h = side_hinge_spacing);
                translate([lamp_x/5 - strut_thickness/2, -strut_thickness, strut_thickness])
                    rotate([0, 90, 0])
                        cylinder(d = screw_strut_dia, h = bottom_hinge_spacing);
            }
            // barndoor screw holes
            translate([(lamp_bevel - strut_thickness)/2, - strut_thickness, lamp_z/5 - f]) 
                cylinder(d = screw_hole_tap_dia, h = side_hinge_spacing + df);
            translate([lamp_x - (lamp_bevel - strut_thickness)/2, - strut_thickness, lamp_z/5 - f])
                cylinder(d = screw_hole_tap_dia, h = side_hinge_spacing + df);
            translate([lamp_x/5 - strut_thickness/2 - f, -strut_thickness, strut_thickness])
                rotate([0, 90, 0])
                    cylinder(d = screw_hole_tap_dia, h = bottom_hinge_spacing + df);
        }
}

module cage_top() {
    color("DeepSkyBlue") {
        difference() {
            union() {
                // crossbeam
                difference() {
                    translate([0, lamp_y/3, 0]) {
                        cube([lamp_x, strut_thickness, strut_thickness]);
                        translate([-f, strut_thickness/2, strut_thickness/2])
                            rotate([0, 90, 0])
                                cylinder(d = screw_hole_tap_dia, h = lamp_x/5);
                        translate([lamp_x - lamp_x/5 + f, strut_thickness/2, strut_thickness/2])
                            rotate([0, 90, 0])
                                cylinder(d = screw_hole_tap_dia, h = lamp_x/5);
                    }
                }
                // front and back brackets
                translate([knob_dia  + strut_thickness/2, 0, strut_thickness]) {
                    rotate([0, 180, 0])
                        front_bracket();
                    translate([0, lamp_y, 0])
                        rotate([0, 180, 180])
                            front_bracket();
                }
                translate([lamp_x - knob_dia - strut_thickness/2, 0, strut_thickness]) {
                    rotate([0, 180, 0])
                        front_bracket();   
                    translate([0, lamp_y, 0])
                        rotate([0, 180, 180])
                            front_bracket();
                }
                // top hinge body
                translate([knob_dia, -strut_thickness, 0 ])
                    rotate([0, 90, 0]) 
                        cylinder(d = screw_strut_dia, h = top_hinge_spacing);
            }
            // top hinge screw hole
            translate([knob_dia - f, -strut_thickness, 0])
                rotate([0, 90, 0]) 
                    cylinder(d = screw_hole_tap_dia, h = top_hinge_spacing + df);
        }
    }
}

module lamp() {
        // body
        translate([0, lamp_y, 0])
            rotate([90, 0, 0]) {
                union() {
                    difference() {
                        color("gray") 
                            box_with_round_edges_3d([lamp_x, lamp_z, lamp_y], knob_dia/2);
                            translate([lamp_bevel, lamp_bevel, lamp_y - 2 + f])
                                color("gray")
                                    box_with_round_edges_3d([lamp_x - 2 * lamp_bevel, lamp_z - 2 * lamp_bevel, 2], knob_dia/2 - lamp_bevel);                        
                    }
                    translate([lamp_bevel, lamp_bevel, lamp_y - 2 + f])
                        color("White")
                            box_with_round_edges_3d([lamp_x - 2 * lamp_bevel, lamp_z - 2 * lamp_bevel, f], knob_dia/2 - lamp_bevel);
            }
        }
            
        // cold shoe mount    
         color("gray") 
            translate([lamp_x/2, lamp_y/2, -10])
                cylinder(d = lamp_y, h = 10);
        
    color("SlateGrey") {
        // usb-port
        translate([usb_pos_x, usb_pos_y, usb_pos_z])
            cube([usb_size_x, usb_size_y, usb_size_z]);
        // knob
        translate([knob_dia/2, lamp_y, lamp_z - knob_dia/2])
            rotate([-90, 0, 0])
                cylinder(d1 = knob_dia, d2 = knob_dia_2, h = knob_protrusion);
        // knob
        translate([lamp_z - knob_dia/2, lamp_y, lamp_z - knob_dia/2])
            rotate([-90, 0, 0])
                cylinder(d1 = knob_dia, d2 = knob_dia_2, h = knob_protrusion);
    }    
}

module barndoor(hinge_spacing, door_offset_index, outer_width, hinge_offset = 0) {
    hinge_z_extension = (3 - door_offset_index) * barndoor_thickness * 1.5 + screw_strut_dia/2 + barndoor_thickness;
    max_hinge_z_extension = 3 * barndoor_thickness * 1.5 + screw_strut_dia/2 + barndoor_thickness;
    flap_z_offset = door_offset_index * barndoor_thickness * 1.5 - screw_strut_dia/2;
    screw_head_clearance = (barndoor_size - hinge_spacing)/2 - strut_thickness;
    
    color("MediumPurple")
    translate([screw_head_clearance, 0, 0])
        difference() {
            union() {
                // left hinge
                hull() {
                    rotate([90, 0, 90])
                        cylinder(d = screw_strut_dia, h = strut_thickness);
                    translate([0, -screw_strut_dia/2, -hinge_z_extension])
                        cube([strut_thickness, screw_strut_dia, hinge_z_extension]);
                }
                // right hinge
                translate([hinge_spacing + strut_thickness, 0, 0])
                hull() {
                    rotate([90, 0, 90])
                        cylinder(d = screw_strut_dia, h = strut_thickness);
                    translate([0, -screw_strut_dia/2, -hinge_z_extension])
                        cube([strut_thickness, screw_strut_dia, hinge_z_extension]);
                }
                // flap
                translate([hinge_offset, 0, -max_hinge_z_extension + screw_strut_dia/2])
                    hull() {
                        translate([-(barndoor_size - hinge_spacing)/2 + strut_thickness, 0, flap_z_offset])
                            cube([barndoor_size, barndoor_thickness, barndoor_thickness]);
                        translate([-(outer_width - hinge_spacing)/2 + strut_thickness, barndoor_size - screw_strut_dia/2, flap_z_offset])
                            cube([outer_width, barndoor_thickness, barndoor_thickness]);
                    }
            }
            // ensure that screws can actually be screwed in
            // screw head clearance
            translate([-screw_head_clearance -f, 0, 0])
                rotate([90, 0, 90])
                    cylinder(d = screw_head_dia, h = screw_head_clearance + f);
            translate([hinge_spacing + 2 * strut_thickness, 0, 0])
                rotate([90, 0, 90])
                    cylinder(d = screw_head_dia, h = screw_head_clearance + f);
            // screw holes
            translate([-screw_head_clearance - f, 0, 0])
                rotate([90, 0, 90])
                    cylinder(d = screw_hole_dia, h = barndoor_size + df);
        }
}


/**
 * Renders the barndoors correctly assembled for the assembly view.
 * The open_angle defines the flap angle in the view. Pass -90 to
 * display the doors fully closed, Pass 35 to view the as open as the
 * frame allows.
 */
module barndoor_assembly(open_angle) {
    // top
    translate([barndoor_gap/2, -strut_thickness, lamp_z])
        rotate([180 - open_angle, 0, 0])
            barndoor(top_hinge_spacing, 0, barndoor_size);
    
    // bottom
    translate([lamp_x- barndoor_gap/2, -strut_thickness, 0])
        rotate([-open_angle, 0, 180])
            barndoor(bottom_hinge_spacing, 1, barndoor_size);

    // side hinges are a little more complicated as the mounts do not 
    // sit in the middle, so some offset calculation is required
    side_z_offset = lamp_z/5 - (barndoor_size - side_hinge_spacing)/2 - strut_thickness;
    side_hinge_offset = (lamp_z - side_hinge_spacing - 2 * strut_thickness)/5;
    
    // left
    translate([0, -strut_thickness, side_z_offset])
        rotate([0, -90, 180 - open_angle])
            barndoor(side_hinge_spacing, 2, barndoor_size, side_hinge_offset);
    // right
    translate([lamp_x, -strut_thickness, side_z_offset + barndoor_size])
        rotate([180 - open_angle, -270, 0])
            barndoor(side_hinge_spacing, 3, barndoor_size, - side_hinge_offset);
    
}

/**
 * Use this to display the completely assembled parts around a mock of the
 * lamp itself. This version is intended for preview only and should not be
 * printed.
 */
module assembly() {
    translate([0, 0, -strut_thickness])
        cage();
    translate([0, 0, lamp_z])
        cage_top();
    // render with open barndoors
    barndoor_assembly(35);
    // render with closed barndoors
    //barndoor_assembly(-90);
    lamp();
}

/**
 * This lays all the parts out for printing. Use this to generate an STL that
 * can be directly used in your slicer.
 */
module print() {
    translate([strut_thickness, 0, lamp_y + strut_thickness])
        rotate([-90, 0, 0])
            cage();
    translate([lamp_x * 2.5, 0, strut_thickness])
        rotate([180, 0, 180])
            cage_top();
    translate([- 2 * lamp_x, 0, 0])
        rotate([-90, 0, 0])
            barndoor_assembly(90);
}

//print();
assembly();