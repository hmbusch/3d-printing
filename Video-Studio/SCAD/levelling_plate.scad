Base_Diameter = 60;
Head_Diameter = 51.2;
Level_Diameter = 12;
Level_Height = 6;
Top_Headroom = 1;
Center_Hole_Diameter = 3/8 * 25.4;
Overhang_Width = 2;
Overhang_Height = 3;
Main_Disc_Height = 1;
Slot_Length = 12;
Slot_Width = 5;

f = 0.01;
df = 2 * f;

$fn = 128;

module baseplate() {
    difference() {
        hull() {
            cylinder(d = Base_Diameter + Overhang_Width * 2, h = Main_Disc_Height + Top_Headroom);
            translate([Base_Diameter/2 + Overhang_Width + Level_Diameter/2, 0, 0])
                cylinder(d = Level_Diameter + Overhang_Width, h = Main_Disc_Height + Top_Headroom);
        }
        translate([0, 0, Main_Disc_Height])
            cylinder(d = Head_Diameter, h = Top_Headroom + f);
        translate([0, 0, -f])
            cylinder(d = Center_Hole_Diameter, h = Main_Disc_Height + Top_Headroom + df);
        hull() {
            translate([-Base_Diameter/2 + Slot_Width/2, 0, -f]) 
                cylinder(d = Slot_Width, h = Main_Disc_Height + df);
            translate([-Base_Diameter/2 + Slot_Length, 0, -f]) 
                cylinder(d = Slot_Width, h = Main_Disc_Height + df);
        }
    }
}

difference() {
    union() {
        baseplate();
        translate([Base_Diameter/2 + Overhang_Width + Level_Diameter/2, 0, -Level_Height + Top_Headroom])
            cylinder(d = Level_Diameter + Overhang_Width, h = Level_Height + Main_Disc_Height);
    }
    translate([Base_Diameter/2 + Overhang_Width + Level_Diameter/2, 0, -Level_Height + Top_Headroom + Main_Disc_Height])
        cylinder(d = Level_Diameter, h = Level_Height + f);
    translate([Base_Diameter/2 + Overhang_Width + Level_Diameter/2, 0, -Level_Height + Top_Headroom - f])
        cylinder(d = Level_Diameter/3, h = Main_Disc_Height + df);
}
translate([0, 0, -Overhang_Height])
    difference() {
            cylinder(d = Base_Diameter + Overhang_Width * 2, h = Overhang_Height);
            translate([0, 0, -f])
            cylinder(d = Base_Diameter, h = Overhang_Height + df);
        }
    

//cylinder(d = Level_Diameter + Overhang_Width, h = Level_Height + Main_Disc_Height);




//difference() {
//    cylinder(d = Base_Diameter + Overhang_Width * 2, h = Main_Disc_Height);
//    translate([0, 0, -f])
//        cylinder(d = Center_Hole_Diameter, h = Main_Disc_Height + df);
//}