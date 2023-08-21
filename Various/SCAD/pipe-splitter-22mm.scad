Connector_Diameter = 22;
Connector_Length = 45;
Connector_Mating_Length = 20;
Connector_Wall_Thickness = 3;

Regulator_Hole_Diameter = 8;
Regulator_Wall_Thickness = 2;
Regulator_Height = 10;
Regulator_Outer_Diameter = Regulator_Hole_Diameter + 2 * Regulator_Wall_Thickness;


$fn = 128;
f = 0.01;
df = 2 * f;

difference() {
    union() {
        cylinder(d = Connector_Diameter, h = Connector_Length);
        translate([Regulator_Height/2, 0, (Connector_Length - Connector_Mating_Length) * 2/3])
            rotate([0,90,0])
                cylinder(d2 = Regulator_Outer_Diameter, d1= Regulator_Outer_Diameter * 1.5, h = Regulator_Height * 1.5);
    }
    translate([0, 0, -f])
        cylinder(d = Connector_Diameter - 2 * Connector_Wall_Thickness, h = Connector_Length + df);
    translate([Regulator_Height/2 + f, 0, (Connector_Length - Connector_Mating_Length) * 2/3])
        rotate([0,90,0])
            cylinder(d = Regulator_Hole_Diameter, h = Regulator_Height * 1.5);
    
}