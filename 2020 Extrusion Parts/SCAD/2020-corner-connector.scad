/**
 * Corner bracket for 2020 extrusion (type b, 6mm rabbet)
 */
Extrusion_Size = 20;
Extrusion_Slot_Width = 6;
Extrusion_Slot_Depth = 5;
Extrusion_Slot_Length = 5;

Screw_Hole_Size = 6.1;
Screw_Access_Size = 12;
Screw_Base_Thickness = 2;

Slant_Size = 5;

f = 0.01;
df = 2 * f;
$fn = 128;

module corner_piece() {
    slant_offset = sqrt(2 * Slant_Size^2) / 2;

    union() {
        difference() {
            // main body
            cube(Extrusion_Size);
            
            // slant cut
            translate([0, -slant_offset, -5])
                rotate([0, 0, 45])  
                    color("blue")
                        cube([Slant_Size, Slant_Size, Extrusion_Size + 10]);

            // screw holes
            translate([-5, Extrusion_Size/2, Extrusion_Size/2])
                rotate([0, 90, 0])
                    color("green")
                        cylinder(d = Screw_Hole_Size, h = Extrusion_Size + 10);
            translate([Extrusion_Size/2, -5, Extrusion_Size/2])
                rotate([-90, 0, 0])
                    color("green")
                        cylinder(d = Screw_Hole_Size, h = Extrusion_Size + 10);
            
            // screw head holes
            translate([-f, Extrusion_Size/2, Extrusion_Size/2])
                rotate([0, 90, 0])
                    color("cyan")
                        cylinder(d = Screw_Access_Size, h = Extrusion_Size - Screw_Base_Thickness + f);

            // screw head holes
            translate([Extrusion_Size/2, -f, Extrusion_Size/2])
                rotate([-90, 0, 0])
                    color("cyan")
                        cylinder(d = Screw_Access_Size, h = Extrusion_Size - Screw_Base_Thickness + f);
        }
        
        // extrusion "fins"
        for(z = [0, Extrusion_Size - Extrusion_Slot_Depth]) {
            translate([Extrusion_Size/2 - Extrusion_Slot_Width/2, Extrusion_Size, z]) 
                color("grey")
                    cube([Extrusion_Slot_Width, Extrusion_Slot_Length, Extrusion_Slot_Depth]);
            translate([Extrusion_Size, Extrusion_Size/2 - Extrusion_Slot_Width/2, z]) 
                color("grey")
                    cube([Extrusion_Slot_Length, Extrusion_Slot_Width, Extrusion_Slot_Depth]);
        }
    }
    
}

corner_piece();