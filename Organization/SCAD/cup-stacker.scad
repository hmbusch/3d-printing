use <../../Various/SCAD/rounded_box.scad>

/* [Measurements] */

// Diameter of the cups to stack
Cup_Diameter = 76; // [50:1:150]

// Height of the cups to stack
Cup_Height = 60;    // [40:1:100]

// Number of cups to stack
Stack_Size = 3;     // [1:1:10]

// Cup tower height scale ratio
Tower_Scale = 0.975; // [0.8:0.01:1]

// Longest diagonal the cup has (including the handle)
Cup_Diagonal = 107;      // [50:1:200]

// Angle of the cutout for the handle
Cutout_Angle = 45;    // [30:1:90]

// Desired wall strength
Wall_Strength = 1.6;    // [0.5:0.1:5]

// Additional slack between the cups and the wall
Wall_Slack = 1;   // [0:0.5:10]

// Thickness of the base
Base_Thickness = 4;

/* [Hidden] */

$fn = 64;
f = 0.01;
Tower_Diameter = Cup_Diameter + 2 * Wall_Slack + 2 * Wall_Strength;
Base_Width = Tower_Diameter + ((Cup_Diagonal - Cup_Diameter) / sqrt(2));

echo(Base_Width);
echo(Tower_Diameter);

module tower() {
    rotate([0, 0, -15])
        rotate_extrude(angle = 360 - Cutout_Angle)
            translate([Tower_Diameter/2 - Wall_Strength, 0, 0])
                square([Wall_Strength, Tower_Scale * Stack_Size * Cup_Height]);
}

module base() {
    box_with_round_edges_3d([Base_Width, Base_Width, Base_Thickness], 5);
}

base();
translate([Tower_Diameter/2, Base_Width - Tower_Diameter/2, Base_Thickness]) 
    tower();
