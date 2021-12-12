use <screw_holes.scad>
use <rounded_box.scad>

/* [Measurements] */

// Distance between the screw holes
Hole_Spacing = 118; // [50:0.5:300]

// Diameter of the screw holes
Hole_Size = 4.2;    // [3.2:M3, 4.2:M4, 5.2:M5]

// Nut size
Nut_Size = 7.3;     // [5.5:M3, 7.3:M4, 8.0:M5]

// The depth by which the nut is sunk into the bar
Nut_Depth = 6;      // [1.8:0.1:10]

// The height of the bar in total
Bar_Height = 14;    // [5:1:20]

// The depth of the bar 
Bar_Depth = 18;    // [6:1:30]

// The width of the bar (must be > Hole Spacing)
Bar_Width = 145;   // [10:1:300]

$fn = 64;
f = 0.01;

module bar() {
    top_offset_x = (Bar_Width - (Hole_Spacing + 3 * Nut_Size))/2;
    top_offset_y = Bar_Depth/4;

    hull() {
        box_with_round_edges_3d([Bar_Width, Bar_Depth, Bar_Height/3], 5);
        translate([top_offset_x, top_offset_y, 0])
            box_with_round_edges_3d([Hole_Spacing + 3 * Nut_Size, Bar_Depth/2, Bar_Height], 5); 
    }
}

module screw_holes() {
    translate([-Hole_Spacing/2, 0, -f]) {
        screw_trap(Hole_Size, Nut_Size, Bar_Height - Nut_Depth + f, Nut_Depth + f, true);
    } 
    translate([Hole_Spacing/2, 0, -f]) {
        screw_trap(Hole_Size, Nut_Size, Bar_Height - Nut_Depth + f, Nut_Depth + f, true);
    }    
}

difference() {
    translate([-Bar_Width/2, -Bar_Depth/2, 0])
        bar();    
    screw_holes();
}