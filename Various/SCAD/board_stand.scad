include <rounded_box.scad>;
include <screw_holes.scad>;

Stand_Length = 200;
Stand_Width = 30;
Stand_Base_Height = 15;
Stand_Slot_Height = 10;
Stand_Slot_Length = 30;
Slot_Depth = 16;
Slot_Width = 15.2;
Slot_Offset = 10;

Screw_Diameter = 3.8;
Screw_Head_Diameter = 8;

$fn = 64;
f = 0.01;
df = 2*f;

difference() {
    union() {
        box_with_round_edges_3d([Stand_Width, Stand_Length, Stand_Base_Height], 3);
        translate([0, Slot_Offset, Stand_Base_Height])
            box_with_round_edges_3d([Stand_Width, Stand_Slot_Length, Stand_Slot_Height]); 
    }
    translate([-f, Slot_Offset + Stand_Slot_Length/2 - Slot_Width/2, Stand_Base_Height + Stand_Slot_Height -Slot_Depth])
        cube([Stand_Width + df, Slot_Width, Slot_Depth + f]);

    translate([Stand_Width/2, Slot_Offset + Stand_Slot_Length/2, Stand_Base_Height*2/3])
        rotate([0, 180, 0])
            screw_trap(Screw_Diameter, Screw_Head_Diameter, Stand_Base_Height * 1/3 + 1, Stand_Base_Height * 1/3);
}
