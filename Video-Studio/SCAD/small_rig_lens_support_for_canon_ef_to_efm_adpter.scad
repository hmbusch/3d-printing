/**
 * Lens support for Small Rig Camera Cage & Canon/Viltrox EF to EF-M adapter
 *
 * Designed using the Small Rig Camera L-Bracket for the Canon M50 (#2387)
 * and the Viltrox Mount Adapter EF EOS M. Should also fit for similar Small 
 * Rig cages and the original Canon adapter.
 *
 */

Cage_Screw_Diameter = 4.2;
Cage_Screw_Spacing = 36;

Mount_Width = 50;
Mount_Height = 10;
Mount_Thickness = 4;

Cage_Lens_Cutout_Diameter = 68;
Cage_Lens_Cutout_Offset = 0;

Cage_Lens_Support_Spacing = 10;
Lens_Support_Screw_Hole_Dia = 5.2;
Lens_Support_Screw_Head_Dia = 9.5;
Lens_Support_Screw_Head_Height = 3;
Lens_Support_Width = 24;
Lens_Support_Height = Mount_Height;

f = 0.01;
df = 2*f;
$fn = 64;

module cage_side_mount_drawing() {
    translate([-Cage_Screw_Spacing/2, 0, 0])
        circle(d = Cage_Screw_Diameter);
    translate([Cage_Screw_Spacing/2, 0, 0])
        circle(d = Cage_Screw_Diameter);
    translate([0, Cage_Lens_Cutout_Diameter / 2 + Cage_Lens_Cutout_Offset, 0])
        circle(d = Cage_Lens_Cutout_Diameter, $fn = 128);    
}

module cage_side_mounting_plate() {
    difference() {
        translate([- Mount_Width/2, -Mount_Height/2, 0])
            cube([Mount_Width, Mount_Height, Mount_Thickness]); 
        translate([0, 0, -f])
            linear_extrude(Mount_Thickness + df)
                cage_side_mount_drawing();
    }
}

module lens_support_mount() {
    Lens_Support_Length = Cage_Lens_Support_Spacing + 2 * Lens_Support_Screw_Hole_Dia;
    difference() {
        translate([-Lens_Support_Width/2, -Lens_Support_Height/2, 0])
            cube([Lens_Support_Width, Lens_Support_Height, Lens_Support_Length]);
        translate([0, 0, -f])
            linear_extrude(Lens_Support_Length + df)
                cage_side_mount_drawing(); 
        
        screw_diameter = [Lens_Support_Screw_Hole_Dia, Lens_Support_Screw_Head_Dia];
        cutout_height = [Lens_Support_Height, Lens_Support_Screw_Head_Height + f];
        cutout_y_offset = [Lens_Support_Height/2, -(Mount_Height/2 - cutout_height[1]) - f];

        for(cutout_index = [0, 1]) {
            hull() {
                for(slot_offset = [-1, 2]) {
                    translate([0, cutout_y_offset[cutout_index], Cage_Lens_Support_Spacing + slot_offset])
                        rotate([90, 0, 0])
                            cylinder(d = screw_diameter[cutout_index], h = cutout_height[cutout_index]);
                }
            }
        }
    }
}

union() {
    cage_side_mounting_plate();
    lens_support_mount();
}


