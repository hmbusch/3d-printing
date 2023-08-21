/* [Filter Settings] */
Filter_Diameter = 52;
Filter_Thickness = 7.15;

/* [Case Settings] */
Case_Thickness = 1;
Width_Offset = -0.1;
Thickness_Offset = -0.1;
Height_Offset = 1;

/* [Hidden] */
Case_X = Filter_Diameter + 2*Case_Thickness + Width_Offset;
Case_Y = Filter_Thickness + 2*Case_Thickness + Thickness_Offset;
Case_Z = Filter_Diameter + Case_Thickness + Height_Offset;

f = 0.01;
df = 2*f;
$fn = 64;

difference() {
    cube([Case_X, Case_Y, Case_Z]);
    translate([(2*Case_Thickness + Width_Offset)/2, (2*Case_Thickness + Thickness_Offset)/2, Case_Thickness])
        cube([Filter_Diameter + Width_Offset, Filter_Thickness + Thickness_Offset, Filter_Diameter + Height_Offset + f]);
    translate([Case_X/2, Case_Thickness + f, Case_Z + Filter_Diameter/2 * 0.8])
        rotate([90, 0, 0])
            cylinder(d = Filter_Diameter, h = Case_Thickness + df);    
}

