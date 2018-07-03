use <../../Universal/SCAD/rounded_box.scad>;

$fn = 64;
thickness = 2;

module cageBarWithAngle() {
    difference() {
        union() {  
            hull() {
                translate([-1, 0, 0]) box_with_round_edges(width = 7, depth = 8.5, height = thickness + 1, edge_radius = 2);
                translate([8, 10, 0]) box_with_round_edges(width = 5, depth = 5, height = thickness + 1, edge_radius = 2);
            }

            hull() {
                translate([32, 0, 0]) box_with_round_edges(width = 7, depth = 8.5, height = thickness + 1, edge_radius = 2);
                translate([25, 10, 0]) box_with_round_edges(width = 5, depth = 5, height = thickness + 1, edge_radius = 2);
            }

            translate([8, 10, -5]) box_with_round_edges(width = 22, depth = 5, height = thickness + 5, edge_radius = 2);
        }
        
        translate([2.6, 8.5/2, -0.1]) cylinder(d = 2.9, h = thickness + 1.2);
        translate([2.6, 8.5/2, thickness - .6 + 0.1]) cylinder(d = 4.8, h = 1.6);
        translate([38 - 2.6, 8.5/2, -0.1]) cylinder(d = 2.9, h = thickness + 1.2);
        translate([38 - 2.6, 8.5/2, thickness - .6 + 0.1]) cylinder(d = 4.8, h = 1.6);
        translate([(38-5)/2, 12, -6]) cube([5, 5, 9]);
    }
    
    
}

cageBarWithAngle();