Magnet_Diameter = 8;
Magnet_Thickness = 3;
Magnet_Side_Thickness = 4;

Screw_Diameter = 5.2;
Screw_Side_Thickness = 5;

Extrusion_Y = 20;
Extrusion_Z = 20;
Extrusion_Slot_Width = 5.8;
Extrusion_Slot_Height = 1.8;

Part_X = 40;

f = 0.01;

$fn = 64;

module bracket() {
    cube_x = Part_X;
    cube_y = Magnet_Side_Thickness + Extrusion_Y; 
    cube_z = Screw_Side_Thickness + Extrusion_Z;

    union() {
        difference() {
            union() {
                // Bracket
                difference() {
                    cube([cube_x, cube_y, cube_z]);
                    translate([-Part_X/2, Magnet_Side_Thickness, Screw_Side_Thickness])
                        cube([Part_X * 2, Extrusion_Y + f, Extrusion_Z + f]);
                }
                // Slot Support
                translate([0, Magnet_Side_Thickness, Screw_Side_Thickness + Extrusion_Z/2 - Extrusion_Slot_Width/2])
                    cube([cube_x, Extrusion_Slot_Height, Extrusion_Slot_Width]);
                translate([0, Magnet_Side_Thickness + Extrusion_Y/2 - Extrusion_Slot_Width/2, Screw_Side_Thickness])
                    cube([cube_x, Extrusion_Slot_Width, Extrusion_Slot_Height * 0.8]);
            }
            // Magnet cutouts
            translate([Part_X/5, Magnet_Side_Thickness + Extrusion_Slot_Height + f, Screw_Side_Thickness + Extrusion_Z/2])
                rotate([90, 0, 0])
                    cylinder(d = Magnet_Diameter, h = Magnet_Thickness + Extrusion_Slot_Height + f);
            translate([Part_X * 4/5, Magnet_Side_Thickness + Extrusion_Slot_Height + f, Screw_Side_Thickness + Extrusion_Z/2])
                rotate([90, 0, 0])
                    cylinder(d = Magnet_Diameter, h = Magnet_Thickness + Extrusion_Slot_Height + f);
            // Scre holes
            translate([Part_X/5, Magnet_Side_Thickness + Extrusion_Y/2, -f])
                cylinder(d = Screw_Diameter, h = Screw_Side_Thickness + Extrusion_Slot_Height);
            translate([Part_X * 4/5, Magnet_Side_Thickness + Extrusion_Y/2, -f])
                cylinder(d = Screw_Diameter, h = Screw_Side_Thickness + Extrusion_Slot_Height);
            
        }       
    }
}


bracket();

