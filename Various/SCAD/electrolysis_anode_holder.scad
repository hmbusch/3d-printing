use <../../Various/SCAD/rounded_box.scad>

$fn = 32;

anode_x = 250;
anode_y = 6;
anode_z = 30;

anode_hole = 5.2;
anode_hole_offset = 15;

box_ledge_width = 15;
box_overhang = 60;
anode_overhang = 30;

holder_thickness = 8;
    
cable_routing_x = anode_overhang + 5;
cable_routing_y = 5;
cable_routing_z = 8;

cable_hole = 5;
    
f = 0.01;
df = f * 2;

box_x = holder_thickness + box_overhang;

module holder() {
    difference() {       
        // main body
        box_with_round_edges_3d([box_x, 4 * holder_thickness + box_ledge_width + anode_y, anode_z]);
        // cutout for box ledge
        translate([holder_thickness, holder_thickness, -f]) 
            cube([box_overhang + f, box_ledge_width, anode_z + df]);
        // cutout for anode        
        translate([box_x - cable_routing_x - 1, 3 * holder_thickness + box_ledge_width, -f])
            cube([cable_routing_x + f + 1, anode_y, anode_z + df]);
        // anode screw hole
        hole_height = anode_y + 2 * holder_thickness + df;
            translate([box_x - anode_overhang/2, hole_height + 2 * holder_thickness + box_ledge_width - f, anode_z/2])
                rotate([90, 0, 0])
                    cylinder(d = anode_hole, h = hole_height);
        // cutout for connector
        translate([-f, 3 * holder_thickness + box_ledge_width, anode_z/2]) {
            translate([box_x - cable_routing_x - 1, -cable_routing_y + f, -cable_routing_z/2])            
                cube([cable_routing_x + df + 1, cable_routing_y, cable_routing_z]);
            translate([0, -cable_routing_y/2, 0])
                rotate([0, 90, 0])
                    cylinder(d = cable_hole, h = box_x + df);
        }        
    }
}

module anode() {
    color("gray")
        difference() {
            cube([anode_x, anode_y, anode_z]);    
            translate([anode_hole_offset, anode_y * 1.5, anode_z/2]) 
                rotate([90, 0, 0])
                    cylinder(d = anode_hole, h = 2 * anode_y);
        }
}

holder();
//translate([box_x - anode_overhang, 3 * holder_thickness + box_ledge_width, -f])
//    #anode();
