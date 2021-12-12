use <../../Various/SCAD/rounded_box.scad>

socket_x = 71;
socket_y = 71;
socket_z = 35;

sonoff_x = 88;
sonoff_y = 40;
sonoff_z = 25;

cable_slack = 15;
cable_dia = 5.5;

wall_thickness = 1.8;

box_edge_radius = 4;

screw_hole_dia = 2.5;
screw_hole_offset = 5;
screw_hole_post_dia = 3 * screw_hole_dia;
screw_hole_post_middle_compensation = 1;
screw_head_dia = 6;
screw_dia = 3.2;

grommet_dia = 10;

$fn = 64;
f = 0.01;
df = 2 * f;

// Derived values, do not edit

box_x = 2 * socket_x;
box_y = socket_y;
box_z = socket_z + wall_thickness;

box_inner_x = 2 * (socket_x - wall_thickness);
box_inner_y = socket_y - 2 * wall_thickness;
box_inner_z = socket_z;

box_inner_edge_radius = box_edge_radius - wall_thickness;

sonoff_box_x = sonoff_x + 2 * wall_thickness + 2 * cable_slack;
sonoff_box_y = sonoff_y + 2 * wall_thickness;
sonoff_box_z = sonoff_z + wall_thickness;

module socket_box() {
    difference() {
        union() {
            difference() {
                box_with_round_edges_3d([box_x, box_y, box_z], box_edge_radius);
                translate([wall_thickness, wall_thickness, wall_thickness + f])
                    box_with_round_edges_3d([box_inner_x, box_inner_y, box_inner_z + f], box_inner_edge_radius);
            }
            // Screw posts
            // front (long side)
            translate([socket_x/2 - screw_hole_post_dia/2, wall_thickness, wall_thickness])
                box_with_round_edges_3d([screw_hole_post_dia, screw_hole_post_dia, box_inner_z], edges = [false, false, true, true]);
            translate([socket_x * 1.5  - screw_hole_post_dia/2, wall_thickness, wall_thickness])
                box_with_round_edges_3d([screw_hole_post_dia, screw_hole_post_dia, box_inner_z], edges = [false, false, true, true]);
            // back (long side)
            translate([socket_x/2 - screw_hole_post_dia/2, socket_y - screw_hole_post_dia - wall_thickness, wall_thickness])
                box_with_round_edges_3d([screw_hole_post_dia, screw_hole_post_dia, box_inner_z], edges = [true, true, false, false]);
            translate([socket_x * 1.5  - screw_hole_post_dia/2, socket_y - screw_hole_post_dia - wall_thickness, wall_thickness])
                box_with_round_edges_3d([screw_hole_post_dia, screw_hole_post_dia, box_inner_z], edges = [true, true, false, false]);
            // left (short side)
            translate([screw_hole_offset - screw_hole_post_dia/2, socket_y/2  - screw_hole_post_dia/2, wall_thickness])
                box_with_round_edges_3d([screw_hole_post_dia, screw_hole_post_dia, box_inner_z], edges = [false, true, false, true]);
            // right (short side)
            translate([box_x - screw_hole_post_dia - wall_thickness, socket_y/2 - screw_hole_post_dia/2, wall_thickness])
                box_with_round_edges_3d([screw_hole_post_dia, screw_hole_post_dia, box_inner_z], edges = [true, false, true, false]);
            // middle
            translate([socket_x - screw_hole_post_dia - wall_thickness - screw_hole_post_middle_compensation/2, socket_y/2 - screw_hole_post_dia/2, wall_thickness])
                box_with_round_edges_3d([screw_hole_post_dia * 2 + 2 * wall_thickness + screw_hole_post_middle_compensation, screw_hole_post_dia, box_inner_z]);
            
        }
        
        // Holes for lid socket screws (need to tap these)
        for (x_offset = [socket_x/2, socket_x * 1.5, screw_hole_offset, socket_x - screw_hole_offset, socket_x + screw_hole_offset, box_x - screw_hole_offset]) {
            for(y_offset = [screw_hole_offset, socket_y - screw_hole_offset,  socket_y/2]) {
                 translate([x_offset, y_offset, wall_thickness + socket_z/2]) 
                    cylinder(d = screw_hole_dia, h = socket_z/2 + f);
            }
        }
    }
}

module sonoff_box() {
    difference() {
        union() {
            difference() {
                box_with_round_edges_3d([sonoff_box_x, sonoff_box_y, sonoff_box_z], box_edge_radius, edges = [false, false, true, true]);
                translate([wall_thickness, wall_thickness, 2 * wall_thickness + f])
                    cube([sonoff_x + 2 * cable_slack, sonoff_y, sonoff_z + f]);
                translate([sonoff_box_x/2 - sonoff_x/2, sonoff_box_y/2 - sonoff_y/2, wall_thickness])
                    cube([sonoff_x, sonoff_y, sonoff_z]);
                // Make some room for the grommet on the inside
                translate([wall_thickness, sonoff_box_y * 1/4, wall_thickness])
                    cube([wall_thickness * 2, sonoff_box_y/2, sonoff_box_z/3]);
                
            }
            difference() {
                translate([wall_thickness * 3, sonoff_box_y * 1/4, 0])
                    cube([screw_hole_post_dia, sonoff_box_y/2, sonoff_box_z/3]);
                translate([wall_thickness * 3 + screw_hole_post_dia/2, sonoff_box_y/4 + sonoff_box_y/6/2, wall_thickness +f])
                    cylinder(d = screw_hole_dia, h = sonoff_box_z/3 - wall_thickness);
                translate([wall_thickness * 3 + screw_hole_post_dia/2, sonoff_box_y * 3/4 - sonoff_box_y/6/2, wall_thickness +f])
                    cylinder(d = screw_hole_dia, h = sonoff_box_z/3 - wall_thickness);
            }
        }
        translate([- wall_thickness/2, sonoff_box_y/2, sonoff_box_z/3])
            rotate([0, 90, 0])
                cylinder(d = grommet_dia, h = wall_thickness * 2); 
        translate([- wall_thickness/2, sonoff_box_y/2, sonoff_box_z/3])
            rotate([0, 90, 0])
                cylinder(d = cable_dia, h = sonoff_x/2); 
    }
    
    for(x_offset = [box_edge_radius, sonoff_box_x - box_edge_radius]) {
        for(y_offset = [box_edge_radius, sonoff_box_y - box_edge_radius]) {
            translate([x_offset, y_offset, wall_thickness])
                difference() {
                    cylinder(d = box_edge_radius * 2, h = sonoff_z);
                    translate([0, 0, sonoff_z/2 + f])
                        cylinder(d = screw_hole_dia, h = sonoff_z/2);
                }            
        }
    }
}

module sonoff_lid() {
    difference() {
        box_with_round_edges_3d([sonoff_box_x, sonoff_box_y, wall_thickness], box_edge_radius, edges = [false, false, true, true]);
        for(x_offset = [box_edge_radius, sonoff_box_x - box_edge_radius]) {
            for(y_offset = [box_edge_radius, sonoff_box_y - box_edge_radius]) {
                translate([x_offset, y_offset, -f]) {
                    cylinder(d = screw_hole_dia, h = wall_thickness + df);
                    translate([0, 0, wall_thickness/3]) {
                        cylinder(d1 = screw_hole_dia, d2 = screw_head_dia, h = wall_thickness * 2/3 + df);
                    }
                }
            }
        }
    }
}

module sonoff_strain_relief() {
    difference() {
        cube([screw_hole_post_dia, sonoff_box_y/2, 2 * wall_thickness]);
        translate([-f, sonoff_box_y/4, -wall_thickness])
            rotate([0, 90, 0])
                cylinder(d = cable_dia, h = screw_hole_post_dia + df);
        translate([screw_hole_post_dia/2, sonoff_box_y/6/2, -f])
            cylinder(d = screw_dia, h = 2 * wall_thickness + df);
        translate([screw_hole_post_dia/2, sonoff_box_y / 2 - sonoff_box_y/6/2, -f])
            cylinder(d = screw_dia, h = 2 * wall_thickness + df);
    }
}

module socket() {
    difference() {
        union() {
            translate([box_x - (box_x - sonoff_box_x)/2, 0, 0])
                rotate([0, 0, 180])
                    socket_box();
            sonoff_box();
        }
        translate([sonoff_x + cable_slack - screw_hole_post_dia/2, -wall_thickness - f, 2 * wall_thickness])
            cube([cable_slack, 2 * wall_thickness + df, cable_slack]);
        translate([cable_slack - screw_hole_post_dia, -wall_thickness - f, 2 * wall_thickness])
            cube([cable_slack, 2 * wall_thickness + df, cable_slack]);
        
    }
}

socket();

translate([0, sonoff_box_y * 1.2, 0])
    sonoff_lid();

translate([sonoff_box_x + 2 * wall_thickness, sonoff_box_y, 2 * wall_thickness])
    rotate([180, 0, 0])
        sonoff_strain_relief();