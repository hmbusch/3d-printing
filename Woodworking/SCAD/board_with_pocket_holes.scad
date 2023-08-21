Drill_Large_Diameter = 9.5;
Drill_Small_Diameter = 4.2;
Drill_Large_Length = 75;
Drill_Small_Length = 11.6;
Drill_Angle = 15;
Drill_Submerged_Length = 0;

Board_Thickness = 15;
Board_Length = 160;
Board_Height = 50;

Hole_Offset = 15;

$fn = 128;

f = 0.01;

module pocket_hole_drill() {
    rotate([Drill_Angle, 0, 0]) {
        cylinder(d = Drill_Small_Diameter, h = Drill_Small_Length);
        translate([0, 0, Drill_Small_Length - f])
            cylinder(d = Drill_Large_Diameter, h = Drill_Large_Length);
    }
}

module side_board() {
    drillzone = Board_Length - 2*Hole_Offset;

    difference() {
        cube([Board_Length, Board_Thickness, Board_Height]);
        
        for(i = [0:2]) {
            translate([Hole_Offset + i * drillzone/2, Board_Thickness/2, 0])
                pocket_hole_drill();
        }
    }
}    

side_board();
