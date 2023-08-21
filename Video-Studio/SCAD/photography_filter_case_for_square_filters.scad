/**
 * Box with overlapping lid
 *
 * I use this to store square filters for my photocamera. 
 * I print these in TPU for better protection, it also helps the lid
 * to stay on the box more firmly.
 *
 * Copyright Hendrik Busch, 2023
 */
 
 
/* [General settings] */
 
// The width of the object that is supposed to fit inside
Inner_Width = 116; // [30:0.1:200]

// The length of the object that is supposed to fit inside
Inner_Length = 140; // [30:0.1:200]
 
// The height of the object that is supposed to fit inside
Inner_Height = 4; // [1:0.1:40]

// Lid overlap percentage. I recommend to set this to at least 50%, for smaller object even higher.
Lid_Overlap = 85; // [5:5:100]

// Top/bottom wall thickness
Top_Bottom_Wall_Thickness = 1.2; // [0.2:0.1:5]

// Side wall thickness
Side_Wall_Thickness = 1; // [0.2:0.2:5]

/* [Fine tuning] */

// Gap between the box and the lid.
Lid_Gap = 0.1; // [0:0.1:1]

/* [Hidden] */
$fn = 128;
f = 0.01;
df = f*2;

module box_square(inner_width, inner_length, inner_height, bottom_wall_thickness, side_wall_thickness) {
    outer_width = inner_width + side_wall_thickness * 2;
    outer_length = inner_length + side_wall_thickness * 2;
    outer_height = inner_height + bottom_wall_thickness;
    
    difference() {
        cube([outer_width, outer_length, outer_height]);
        translate([side_wall_thickness, side_wall_thickness, bottom_wall_thickness])
            cube([inner_width, inner_length, inner_height + f]);
    }    
}

module box() {
    box_square(Inner_Width, Inner_Length, Inner_Height, Top_Bottom_Wall_Thickness, Side_Wall_Thickness);
}   

module lid() {
    lid_inner_width = Inner_Width + Side_Wall_Thickness*2 + Lid_Gap;
    lid_inner_length = Inner_Length + Side_Wall_Thickness*2 + Lid_Gap;
    lid_inner_height = (Lid_Overlap / 100) * (Inner_Height + Top_Bottom_Wall_Thickness + Lid_Gap); 
    box_square(lid_inner_width, lid_inner_length, lid_inner_height, Top_Bottom_Wall_Thickness, Side_Wall_Thickness);
}

box();
translate([Inner_Width * 1.2, 0, 0])
    lid();