include <../../Various/SCAD/rounded_box.scad>;

Socket_Cutout_Diameter = 68.5;
Socket_Spacing = 71.5;
Plate_Top_Offset = 23;
Plate_Top_Offset_Support_Holes = 8;
Plate_Width = Socket_Cutout_Diameter + Socket_Spacing + 20;
Plate_Height = Socket_Cutout_Diameter + 10 + Plate_Top_Offset; 
Plate_Thickness = 5;

Support_Plate_Width = 135;
Support_Plate_Height = 16;
Support_Plate_Thickness = 3;
Support_Hole_Diameter = 4.2;
Support_Hole_Spacing = (Support_Plate_Width - 20)/4;

f = 0.01;
df = 2 * f;

$fn = 64;

module base_plate() {
    difference() {
        // base plate
        box_with_round_edges_3d([Plate_Width, Plate_Height, Plate_Thickness], 5);
        hull() {
            translate([10 + Socket_Cutout_Diameter/2, Plate_Top_Offset + Socket_Cutout_Diameter/2, -f])
                cylinder(d = Socket_Cutout_Diameter, h = Plate_Thickness + df);
            translate([Plate_Width - 10 - Socket_Cutout_Diameter/2, Plate_Top_Offset + Socket_Cutout_Diameter/2, -f])
                cylinder(d = Socket_Cutout_Diameter, h = Plate_Thickness + df);
        }        
        for(i = [0 : 1 : 4]) {            
            translate([Plate_Width - Support_Plate_Width + i * Support_Hole_Spacing, Plate_Top_Offset_Support_Holes, -f]) 
                cylinder(d = Support_Hole_Diameter, h = Plate_Thickness + df);
        }
    }
}

module support_plate() {
    difference() {
        // base plate
        box_with_round_edges_3d([Support_Plate_Width, Support_Plate_Height, Support_Plate_Thickness], 5);
        for(i = [0 : 1 : 4]) {            
            translate([10 + i * Support_Hole_Spacing, Plate_Top_Offset_Support_Holes, -f]) 
                cylinder(d = Support_Hole_Diameter, h = Plate_Thickness + df);
        }
    }
}

base_plate();
translate([0, 2 * -Support_Plate_Height, 0])
    support_plate();