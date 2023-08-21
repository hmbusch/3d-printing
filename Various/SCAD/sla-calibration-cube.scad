Cube_Size = 30;
Cube_Thickness = 1;
Drainage_Hole = 1;

X_Letter_Comp = 0.01 * Cube_Size;
Y_Letter_Comp = 0.01 * Cube_Size;
Z_Letter_Comp = 0.015 * Cube_Size;

$fn = 128;
f = 0.01;
df = 2* f;



module hollow_cube() {
    difference() {
        cube(Cube_Size);
        translate([Cube_Thickness, Cube_Thickness, Cube_Thickness])
            cube(Cube_Size - 2 * Cube_Thickness);
        translate([Cube_Thickness, Cube_Thickness, -f])
            cube([Drainage_Hole, Drainage_Hole, Cube_Size + df]);
        translate([Cube_Size - Cube_Thickness - Drainage_Hole, Cube_Thickness, -f])     
            cube([Drainage_Hole, Drainage_Hole, Cube_Size + df]);        
        translate([Cube_Thickness, Cube_Size - Cube_Thickness - Drainage_Hole, -f])
            cube([Drainage_Hole, Drainage_Hole, Cube_Size + df]);                
        translate([Cube_Size - Cube_Thickness - Drainage_Hole, Cube_Size - Cube_Thickness - Drainage_Hole, -f])
            cube([Drainage_Hole, Drainage_Hole, Cube_Size + df]);
        
        translate([-f, Cube_Thickness, Cube_Thickness])
            cube([Cube_Size + df, Drainage_Hole, Drainage_Hole]);
        translate([-f, Cube_Size - Cube_Thickness - Drainage_Hole, Cube_Thickness])
            cube([Cube_Size + df, Drainage_Hole, Drainage_Hole]);
        translate([-f, Cube_Thickness, Cube_Size - Cube_Thickness - Drainage_Hole])
            cube([Cube_Size + df, Drainage_Hole, Drainage_Hole]);
        translate([-f, Cube_Size - Cube_Thickness - Drainage_Hole, Cube_Size - Cube_Thickness - Drainage_Hole])
            cube([Cube_Size + df, Drainage_Hole, Drainage_Hole]);

        
        translate([Cube_Thickness, -f, Cube_Thickness])
            cube([Drainage_Hole, Cube_Size + df, Drainage_Hole]);
        translate([Cube_Size - Cube_Thickness - Drainage_Hole, -f, Cube_Thickness])
            cube([Drainage_Hole, Cube_Size + df, Drainage_Hole]);
        translate([Cube_Thickness, -f, Cube_Size - Cube_Thickness - Drainage_Hole])
            cube([Drainage_Hole, Cube_Size + df, Drainage_Hole]);
        translate([Cube_Size - Cube_Thickness - Drainage_Hole, -f, Cube_Size - Cube_Thickness - Drainage_Hole])
            cube([Drainage_Hole, Cube_Size + df, Drainage_Hole]);
    }
}

module lettered_cube() {
    difference() {
        hollow_cube();
        translate([Cube_Size/2, Cube_Thickness*2, Cube_Size/2])
            rotate([90, 0 ,0])
                linear_extrude(height = Cube_Thickness * 3) 
                    text("X", size=20, font = "Arial:style=Black", halign="center", valign="center");
        translate([Cube_Size/2, Cube_Size + Cube_Thickness, Cube_Size/2])
            rotate([90, 0 ,0])
                linear_extrude(height = Cube_Thickness * 3) 
                    text("X", size=20, font = "Arial:style=Black", halign="center", valign="center");
        translate([Cube_Size-Cube_Thickness*2, Cube_Size/2, Cube_Size/2])
            rotate([90, 0, 90])
                linear_extrude(height = Cube_Thickness * 3) 
                    text("Y", size=20, font = "Arial:style=Black", halign="center", valign="center");
        translate([-Cube_Thickness, Cube_Size/2, Cube_Size/2])
            rotate([90, 0, 90])
                linear_extrude(height = Cube_Thickness * 3) 
                    text("Y", size=20, font = "Arial:style=Black", halign="center", valign="center");
        translate([Cube_Size/2, Cube_Size/2, -Cube_Thickness])
            rotate([0, 0, 0])
                linear_extrude(height = Cube_Thickness * 3) 
                    text("Z", size=20, font = "Arial:style=Black", halign="center", valign="center");
        translate([Cube_Size/2, Cube_Size/2, Cube_Size-Cube_Thickness*2])
            rotate([0, 0, 0])
                linear_extrude(height = Cube_Thickness * 3) 
                    text("Z", size=20, font = "Arial:style=Black", halign="center", valign="center");
    }

//    // X-Support
//    translate([Cube_Size/2 - Cube_Thickness/2 + X_Letter_Comp, Cube_Thickness, 0])
//        cube([Cube_Thickness, Cube_Thickness, Cube_Size]);
//    translate([Cube_Size/2 - Cube_Thickness/2 + X_Letter_Comp, Cube_Size - 2 * Cube_Thickness, 0])
//        cube([Cube_Thickness, Cube_Thickness, Cube_Size]);
//
//    
//    // Y-Support
//    translate([Cube_Thickness, Cube_Size/2 - Cube_Thickness/2 + Y_Letter_Comp, 0])
//        cube([Cube_Thickness, Cube_Thickness, Cube_Size]);
//    translate([Cube_Size - 2 * Cube_Thickness, Cube_Size/2 - Cube_Thickness/2 + Y_Letter_Comp, 0])
//        cube([Cube_Thickness, Cube_Thickness, Cube_Size]);
//    
//    // Z-Support
//    translate([0, Cube_Size/3 - Z_Letter_Comp, Cube_Thickness])
//        cube([Cube_Size, Cube_Thickness, Cube_Thickness]);
//    translate([0, Cube_Size/3 * 2 - Z_Letter_Comp/4, Cube_Thickness])
//        cube([Cube_Size, Cube_Thickness, Cube_Thickness]);
//    translate([0, Cube_Size/3 - Z_Letter_Comp, Cube_Size - Cube_Thickness * 2])
//        cube([Cube_Size, Cube_Thickness, Cube_Thickness]);
//    translate([0, Cube_Size/3 * 2 - Z_Letter_Comp/4, Cube_Size - Cube_Thickness * 2])
//        cube([Cube_Size, Cube_Thickness, Cube_Thickness]);    
    
    
}


lettered_cube();