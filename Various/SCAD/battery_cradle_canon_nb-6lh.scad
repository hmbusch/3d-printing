/* [Battery Size] */

Battery_Length = 42;
Battery_Width = 35;
Battery_Height = 7;

Battery_Slop = 0.5;

/* [Contact Positioning] */

Contact_Height = 3.5; // [1:0.1:10]
Contact1_Offset = 4.75;
Contact2_Offset = 11.1;
Contact_Cutout = 15;

/* [Additional Details] */

Wall = 5;
Spring_Travel = 6;
Spring_Diameter = 1.5;
Cradle_Height_Ratio = 0.9; // [0:0.1:1]

/* [Hidden] */

$fn = 64;

difference() {
    cube([Battery_Length + 3 * Wall + Spring_Travel, Battery_Width + 2 * Wall + Battery_Slop, Wall + Cradle_Height_Ratio * Battery_Height + Battery_Slop]);
    translate([2 * Wall + Spring_Travel, Wall + Battery_Slop/2, Wall]) 
        cube([Battery_Length + Battery_Slop, Battery_Width + Battery_Slop, Battery_Height + Battery_Slop]);
    translate([Wall * 2, Wall + Battery_Slop/2, Wall])
        cube([Spring_Travel, Contact_Cutout, Battery_Height + Battery_Slop]); 
    translate([-Wall, Wall + Contact1_Offset, Wall + Contact_Height])
        rotate([0, 90, 0])
            cylinder(d = Spring_Diameter, h = 6 * Wall);
    translate([-Wall, Wall + Contact2_Offset, Wall + Contact_Height])
        rotate([0, 90, 0])
            cylinder(d = Spring_Diameter, h = 6 * Wall);               
}

 