Small_Diameter = 20;
Large_Diameter = 78;
Thickness = 1;

hull() {
    cylinder(d = Small_Diameter, h = Thickness);
    translate([Small_Diameter, 0, 0])
        cylinder(d = Small_Diameter, h = Thickness);
}