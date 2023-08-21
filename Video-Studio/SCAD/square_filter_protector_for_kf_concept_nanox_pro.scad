Frame_Width = 116;
Frame_Height = 116;
Frame_Thickness = 3.2;

Rail_Thickness = 1.9;
Rail_Width = 3.5;

Grip_Top_Width = 25;
Grip_Bottom_Width = 50;
Grip_Height = 16;

f = 0.01;
df = 2 * f;

module plate() {
    difference() {
        union() {
            cube([Frame_Width, Frame_Height, Frame_Thickness]);
            translate([0, Frame_Height, 0])
                grip();
            translate([Grip_Bottom_Width, 0, 0])
                rotate([0, 0, 180])
                    grip();
        }
        translate([-f, -Grip_Height - f, Rail_Thickness])
            cube([Rail_Width + f, Frame_Height + 2 * Grip_Height + 2*f, Frame_Thickness - Rail_Thickness + f]);
        translate([Frame_Width - Rail_Width, -f, Rail_Thickness])
            cube([Rail_Width + f, Frame_Height + 2*f, Frame_Thickness - Rail_Thickness + f]);
    }
}

module grip_part() {
    hull() {
        cube([Grip_Bottom_Width, 0.1, Frame_Thickness]);
        translate([(Grip_Bottom_Width - Grip_Top_Width)/2, Grip_Height - 0.1, 0])
            cube([Grip_Top_Width, 0.1, Frame_Thickness]);
    }
}

module grip() {
    difference() {
        grip_part();
        translate([Grip_Bottom_Width * 0.15, Grip_Height * 0.15, Frame_Thickness/2 + f])
            scale([0.7, 0.7, 0.5])
                grip_part();
    }
}

plate();

