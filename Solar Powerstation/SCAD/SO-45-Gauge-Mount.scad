include <../../Various/SCAD/rounded_box.scad>;

// The hole diameter needed to fit the gauge body
GaugeHoleDiameter = 45.6; // [40:0.1:60]

// The size of the square cover plate of the gauge
GaugeCoverPlateSize = 47; // [40:0.1:60]

// The depth behind the cover plate to fit the gauge
GaugeDepth = 40; // [30:60]

// The size of the mount itself
MountSize = 53; // [42:60]

// The wall thickness of the mount
MountWallThickness = 3; // [1:0.2:5]

// The spacing between the mounting holes in the cover plate
MountingHoleSpacing = 37; // [30:0.1:45]

// The diameter of the mounting hole screws
MountingHoleDiameter = 4.2; // [2.5:0.1:5]

// The core hole for the screws before thread tapping 
MountingHoleTapDiameter = 3.4; // [2.5:0.1:5]

// Width of the cable outlet
CableWidth = 12; // [5:20]

// Height of the cable outlet
CableHeight = 6; // [5:20]

f = 0.01;
df = 2 * f;

$fn = 128;

module mountingHolePattern(ZPosition, Diameter, Height) {
    translate([MountSize/2 - MountingHoleSpacing/2, MountSize/2 - MountingHoleSpacing/2, ZPosition])
        cylinder(d = Diameter, h = Height);
    translate([MountSize/2 + MountingHoleSpacing/2, MountSize/2 - MountingHoleSpacing/2, ZPosition])
        cylinder(d = Diameter, h = Height);
    translate([MountSize/2 + MountingHoleSpacing/2, MountSize/2 + MountingHoleSpacing/2, ZPosition])
        cylinder(d = Diameter, h = Height);        
    translate([MountSize/2 - MountingHoleSpacing/2, MountSize/2 + MountingHoleSpacing/2, ZPosition])
        cylinder(d = Diameter, h = Height);        
}

module gaugePlate() {
    difference() {
        hull() {
            box_with_round_edges_3d([MountSize, MountSize, 1], 4);
            translate([1, 1, MountWallThickness - 1])
                box_with_round_edges_3d([MountSize - 2, MountSize - 2, 1], 4);
        }
        translate([MountSize/2, MountSize/2, -f])
            cylinder(d = GaugeHoleDiameter, h = MountWallThickness + df);
        mountingHolePattern(-f, MountingHoleDiameter, MountWallThickness + df);  
    }
}

module gaugeCase() {
    CaseHeight = GaugeDepth + MountWallThickness;
    
    difference() {
        difference() {
            box_with_round_edges_3d([MountSize, MountSize, CaseHeight], 4);
            translate([MountSize/2, MountSize/2, CaseHeight - 12])
                cylinder(d = GaugeHoleDiameter, h = 12 + f);
            hull() {
                translate([MountSize/2, MountSize/2, CaseHeight - 11])
                    cylinder(d = GaugeHoleDiameter + 1, h = 1 + f);
                translate([MountWallThickness, MountWallThickness, MountWallThickness])
                    box_with_round_edges_3d([MountSize - 2 * MountWallThickness, MountSize - 2 * MountWallThickness, 1], 4);
            }
            mountingHolePattern(CaseHeight - 10, MountingHoleTapDiameter, 10 + f);         
            translate([MountSize/4, MountSize/4, -f])
                cylinder(d = MountingHoleDiameter, h = MountWallThickness + df);
            translate([MountSize * 3/4, MountSize * 3/4, -f])
                cylinder(d = MountingHoleDiameter, h = MountWallThickness + df);
            
        }
        translate([-f, (MountSize - CableWidth)/2, MountWallThickness + CableHeight])
            rotate([0, 90, 0])
                box_with_round_edges_3d([CableHeight, CableWidth, MountWallThickness * 2 + df]); 
    }
}

gaugePlate();
translate([MountSize * 1.5, 0, 0])
    gaugeCase();                