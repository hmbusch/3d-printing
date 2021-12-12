$fn = 128;

bottomThickness = 5;
wallThickness = 3;
cornerHeight = 25;
cornerWidth = 20;
cornerDepth = 31;
powerButtonDia = 11;
powerButtonOffset = 4.8;


module dockHolderCorner(powerButton = true) {

    difference() {
        union() {
            // bottom wall
            cube([cornerWidth, cornerDepth, bottomThickness]);
            
            // side wall
            translate([cornerWidth, -wallThickness, 0])
                cube([wallThickness, cornerDepth + 2 * wallThickness, cornerHeight + bottomThickness]);
            
            // front wall
            translate([0, -wallThickness, 0])
                cube([cornerWidth, wallThickness, bottomThickness + cornerHeight]);
            
            // back wall
            translate([- cornerWidth, cornerDepth, 0])
                cube([cornerWidth * 2, wallThickness, bottomThickness + cornerHeight * 2]);
        }
        
        // cutout for power button
        if (powerButton) {
            translate([cornerWidth - powerButtonOffset - powerButtonDia/2, 0, bottomThickness + powerButtonOffset + powerButtonDia/2])
                rotate([90, 0, 0])
                    cylinder(d = powerButtonDia, h = wallThickness);
        }
    }
}

mirror([1, 0, 0])
    dockHolderCorner(false);

translate([(cornerWidth + wallThickness) * 2, 0, 0])
    dockHolderCorner();
