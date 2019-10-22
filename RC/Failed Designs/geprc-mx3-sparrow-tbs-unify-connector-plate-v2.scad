use <../Universal/SCAD/rounded_box.scad>

$fn = 64;

module sma_raiser() {

    difference() {    
        union() {
            box_with_round_edges(width = 16, depth = 8, height = 9, edge_radius = 2);    

        }
        
        // hole for VTX antenna cable
        translate([8, 4, -5]) cylinder(d = 5.5, h = 20);
            
        // screw holes (need to be tapped for M3 screws)
        translate([14, 4, 3]) cylinder(d = 2.5, h = 7);
        translate([2, 4, 3])  cylinder(d = 2.5, h = 7);
    }
}

module plate() {
    difference() {
        union() {
            hull() {
                // base plate
                box_with_round_edges(width = 16, depth = 13, height = 1.5, edge_radius = 2);
                
                translate([0, 7, 1.5]) box_with_round_edges(width = 16, depth = 6, height = 2, edge_radius = 2);
                
                rotate([30, 0, 0]) box_with_round_edges(width = 16, depth = 8, height = 9, edge_radius = 2);    
            }
            
            rotate([30, 0, 0]) {
                // screw hole reinforcements
                hull() {
                    translate([2, 4, 5]) sphere(d = 6);
                    translate([2, 4, 6]) cylinder(d = 6, h = 3);
                }
                hull() {
                    translate([14, 4, 5]) sphere(d = 6);
                    translate([14, 4, 6]) cylinder(d = 6, h = 3);
                }
            }

            // Mounting fins
            translate([-2, 2, 0]) cube([2, 5, 1.5]);
            translate([16, 2, 0]) cube([2, 5, 1.5]);
        }
        
        rotate([30, 0, 0]) {
            // hole for VTX antenna cable
            translate([8, 4, -5]) cylinder(d = 5.5, h = 20);
            
            // screw holes (need to be tapped for M3 screws)
            translate([14, 4, 3]) cylinder(d = 2.5, h = 7);
            translate([2, 4, 3])  cylinder(d = 2.5, h = 7);
        }
        
        // RX antennas
        translate([10.5, 9, 0]) rotate([0, 45, 0]) translate([0, 0, -2]) cylinder(d = 3, h = 12);
        translate([5.5, 9, 0]) rotate([0, -45, 0]) translate([0, 0, -2]) cylinder(d = 3, h = 12);        
    }
}


plate();

