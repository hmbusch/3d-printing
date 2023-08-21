/**
 * Round box with overlapping lid and label
 *
 * I use this to store filters and adapter rings for my photocamera. 
 * I print these in TPU for better protection, it also helps the lid
 * to stay on the box more firmly.
 *
 * Copyright Hendrik Busch, 2023
 */
 
 
/* [General settings] */
 
// The diameter of the object that is supposed to fit inside
Inner_Diameter = 86; // [10:0.1:100]
 
// The height of the object that is supposed to fit inside
Inner_Height = 7.6; // [1:0.1:40]

// Lid overlap percentage. I recommend to set this to at least 50%, for smaller object even higher.abs
Lid_Overlap = 75; // [5:5:100]

// Top/bottom wall thickness
Top_Bottom_Wall_Thickness = 1.2; // [0.2:0.1:5]

// Side wall thickness
Side_Wall_Thickness = 1; // [0.2:0.2:5]

/* [Label setttings] */

// Print label on the box
Use_Label = true;

// Label text
Label_Text = " RF auf FD Adapter";

// Label depth
Label_Depth = 0.8; // [0.2:0.1:2]

/* [Fine tuning] */

// Gap between the box and the lid.
Lid_Gap = 0.1; // [0:0.1:1]

/* [Hidden] */
$fn = 128;
f = 0.01;
df = f*2;

lid_inner_diameter = Inner_Diameter + Side_Wall_Thickness*2 + Lid_Gap;
lid_inner_height = (Lid_Overlap / 100) * (Inner_Height + Top_Bottom_Wall_Thickness + Lid_Gap); 

module box_cylinder(inner_diameter, inner_height, bottom_wall_thickness, side_wall_thickness) {
    outer_diameter = inner_diameter + side_wall_thickness*2;
    outer_height = inner_height + bottom_wall_thickness;
    
    difference() {
        cylinder(d = outer_diameter, h = outer_height);
        translate([0, 0, bottom_wall_thickness])
            cylinder(d = inner_diameter, h = inner_height + f);
    }
}

module box() {
    box_cylinder(Inner_Diameter, Inner_Height, Top_Bottom_Wall_Thickness, Side_Wall_Thickness);
}   

module lid() {
    box_cylinder(lid_inner_diameter, lid_inner_height, Top_Bottom_Wall_Thickness, Side_Wall_Thickness);
}

module circular_text(diameter, text) {
    circumference = PI * diameter;
    text_length = len(text);
    font_size = circumference / text_length * 0.8;
    angle_per_letter = 360 / text_length;
    for(i = [0 : text_length - 1]) {
        rotate(-i * angle_per_letter) 
            translate([0, diameter/3.2 + font_size/2, 0]) 
                text(text[i], font = "Consolas:style=Regular", size = font_size, valign = "center", halign = "center");
    }
}

module lid_label() {
    lid_outer_diameter = lid_inner_diameter + Side_Wall_Thickness * 2;
    difference() {
        cylinder(d = lid_outer_diameter, h = Label_Depth);
        translate([0, 0, -f])
            linear_extrude(Label_Depth + df)
                circular_text(lid_outer_diameter, Label_Text);
    }
}

box();
if (Use_Label) {
    translate([Inner_Diameter * 1.2, 0, Label_Depth])
        lid();
    translate([Inner_Diameter * 1.2, 0, Label_Depth])
        rotate([180, 0 ,0])
            lid_label();
    
} else {
    translate([Inner_Diameter * 1.2, 0, 0])
        lid();
}