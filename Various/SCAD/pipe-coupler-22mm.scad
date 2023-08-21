/* [Main Settings] */

// The hole diameter of the adapter
Pipe_Diameter = 21.5; // [8:0.1:25]

// Height of the adapter
Adapter_Height = 30; // [10:40]

// Wall thickness of the adapter
Adapter_Thickness = 5; // [1:10]

/* [Hidden] */
// Fudge value for better preview rendering
f = 0.01; // [0:0.01:0.1]

// Number of line segments in a curve
$fn = 128; // [16:1:256]

/**
 * Module declaration to stop the Customizer from picking up the
 * variables that follow this declaration. It serves no functional
 * purpose.
 */
module __Customizer_Limit__ () {}

outer_diameter = Pipe_Diameter + 2*Adapter_Thickness;

module coupler() {
    difference() {
        cylinder(d = outer_diameter, h = Adapter_Height);
        translate([0, 0, -f])
            cylinder(d = Pipe_Diameter, h = Adapter_Height + 2*f);
    }
}

module cap() {
    difference() {
        cylinder(d = outer_diameter, h = Adapter_Height);
        translate([0, 0, Adapter_Thickness])
            cylinder(d = Pipe_Diameter, h = Adapter_Height);
    }
}

coupler();
translate([outer_diameter * 1.2, 0, 0])
    cap();