Circle_Height = 0.3;
Circle_Diameter = 35;

Bed_X = 250;
Bed_Y = 210;

Margin = 15;

// Derived values, do not edit

$fn = 128;

hc = Circle_Diameter / 2;
x_offset = [Margin + hc, Bed_X - Margin - hc];
y_offset = [Margin + hc, Bed_Y - Margin - hc];

module calibration_circle() {
    cylinder(d = Circle_Diameter, h = Circle_Height);
}

for(x = x_offset) {
    for (y = y_offset) {
        translate([x, y, 0])
            calibration_circle();
    }
}

translate([Bed_X/2, Bed_Y/2, 0])
    calibration_circle();
