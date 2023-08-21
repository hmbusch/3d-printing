// The main diameter of the plug
Plug_Diameter = 22;

// The length of the plug
Plug_Length = 40;

// Wall strength for the hollow part of the plug
Plug_Wall_Strength = 2;

// Length of the hollow part of the plug
Plug_Hollow_Length = 30;

// Tap hole diameter for the pressure fitting
Tap_Diameter = 8.8;

// Air outlet hole diameter
Air_Hole_Diameter = 2;

// Mesh curve quality
$fn = 64;

/* [Hidden] */
Plug_Solid_Length = Plug_Length - Plug_Hollow_Length;
Air_Hole_Offset = Plug_Diameter/2 - 1.5*Air_Hole_Diameter;

f = 0.01;
df = 2*f;

module plug() {
    difference() {
        union() {
            difference() {
                cylinder(d = Plug_Diameter, h = Plug_Length);
                translate([0, 0, Plug_Solid_Length])
                    cylinder(d = Plug_Diameter - 2 * Plug_Wall_Strength, h = Plug_Hollow_Length + f);
                translate([-4, 0, -f])
                    cylinder(d = Tap_Diameter, h = Plug_Solid_Length + df);        
            }    
            translate([Air_Hole_Offset, 0, 0])
                cylinder(d = Air_Hole_Diameter * 2, h = Plug_Length);
        }
        translate([Air_Hole_Offset, 0, -f])
            cylinder(d = Air_Hole_Diameter, h = Plug_Length + df);
    }
}

plug();
