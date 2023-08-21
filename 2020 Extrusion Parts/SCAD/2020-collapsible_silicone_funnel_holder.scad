Funnel_Size_L = 55;
Funnel_Size_S = 42;

Funnel_Straight_Segment_Height = 12;
Funnel_Angled_Segment_Height = 8;

Funnel_Wall_Thickness = 5;

Extrusion_Size = 20;
Extrusion_Slot_Width = 6;
Extrusion_Slot_Depth = 4;

Holder_Thickness = 5;
Holder_Length = 50 + Extrusion_Size + Holder_Thickness + Funnel_Wall_Thickness; 

Screw_Diameter = 5.1;


f = 0.01;
df = 2 * f;

$fn = 64;

arm_width = Extrusion_Size + 2 * Holder_Thickness;
arm_height = Funnel_Straight_Segment_Height + Funnel_Angled_Segment_Height;

module funnel_body() {
    translate([0, 0, Funnel_Angled_Segment_Height]) 
        cylinder(d = Funnel_Size_L + 2 * Funnel_Wall_Thickness, h = Funnel_Straight_Segment_Height);
    cylinder(d2 = Funnel_Size_L + 2 * Funnel_Wall_Thickness, d1 = Funnel_Size_S + 2 * Funnel_Wall_Thickness, h = Funnel_Angled_Segment_Height);
}
    
module funnel_inner_body() {
    translate([0, 0, Funnel_Angled_Segment_Height - f]) 
        cylinder(d = Funnel_Size_L, h = Funnel_Straight_Segment_Height + df);

    translate([0, 0, -f])
        cylinder(d2 = Funnel_Size_L, d1 = Funnel_Size_S, h = Funnel_Angled_Segment_Height + df);
}

module funnel_arm_body() {
    union() {
        funnel_body();
        translate([-arm_width/2, Funnel_Size_S/2, 0])
            cube([arm_width, Holder_Length, arm_height]);
    }
}

module funnel_arm() {
    difference() {
        union() {
            difference() {
                funnel_arm_body();
                funnel_inner_body();
                
                // extrusion cutout
                translate([-arm_width/2 + Holder_Thickness, Funnel_Size_S/2 + Holder_Length - (Extrusion_Size + Holder_Thickness), -f])
                    cube([Extrusion_Size, Extrusion_Size, arm_height + df]);
            }
            // extrusion slot guides
            translate([-arm_width/2, Funnel_Size_S/2, 0]) {
                translate([arm_width/2 - Extrusion_Slot_Width / 2, Holder_Length - (Extrusion_Size + Holder_Thickness), 0])
                    color("grey")
                        cube([Extrusion_Slot_Width, Extrusion_Slot_Depth, arm_height]); 
                translate([Holder_Thickness, Holder_Length - (Extrusion_Size/2 + Holder_Thickness + Extrusion_Slot_Width/2), 0])
                    color("grey")
                        cube([Extrusion_Slot_Depth, Extrusion_Slot_Width, arm_height]); 
                translate([Holder_Thickness + Extrusion_Size - Extrusion_Slot_Depth, Holder_Length - (Extrusion_Size/2 + Holder_Thickness + Extrusion_Slot_Width/2), 0])
                    color("grey")
                        cube([Extrusion_Slot_Depth, Extrusion_Slot_Width, arm_height]); 
            }
        }
        // screw hole
        translate([0, Funnel_Size_S/2 + Holder_Length + f, arm_height/2])
        rotate([90, 0, 0])
            color("blue")
                cylinder(d = Screw_Diameter, h = Extrusion_Size);
    }
}

funnel_arm();