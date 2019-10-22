use <../Universal/SCAD/rounded_box.scad>

$fn = 64;

module plate() {
    difference() {
        union() {
            box_with_round_edges(width = 16, depth = 15, height = 4, edge_radius = 2);
            // Mounting fins
            translate([-2, 4, 2]) cube([2, 5, 1.5]);
            translate([16, 4, 2]) cube([2, 5, 1.5]);
        }
        
        // cutout for SMA bracket
        translate([0, 2, 2.6]) cube([16, 6, 1.4]);
        // holes for mounting screws
        hull() {
            //translate([1.8, 5, 0]) cylinder(d = 3.1, h = 5);
            translate([2, 5, 0]) cylinder(d = 3.1, h = 5);
        }
        hull() {
            translate([14, 5, 0]) cylinder(d = 3.1, h = 5);
            //translate([14.2, 5, 0]) cylinder(d = 3.1, h = 5);
        }
        // hole for SMA connector
        translate([8, 5, 0]) cylinder(d = 6.5, h = 5);
        
        // hole for rx antennas
        translate([10, 11.5, 0]) rotate([0, 40, 0]) translate([0, 0, -2]) cylinder(d = 3, h = 9);
        translate([6, 11.5, 0]) rotate([0, -40, 0]) translate([0, 0, -2]) cylinder(d = 3, h = 9);
    }
}


plate();