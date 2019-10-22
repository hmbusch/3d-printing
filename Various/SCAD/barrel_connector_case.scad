tolerance = 0.01;
connectorDia = 7.6;
connectorNutDia = 12.2;
$fn = 64;

module nutTrap(height = 3, diameter = 6) {
    upscaleRatio = 1/cos(180/6);
    cylinder(r = (diameter * 0.96)/2 * upscaleRatio, h = height, $fn=6);
}

module connectorCase() {
    difference() {
        // main body
        cylinder(d = 18.5, h = 26);
        
        // upper cutout
        translate([0, 0, 5]) cylinder(d = 16, h = 25);
        
        // connector cutout
        translate([0, 0, -tolerance]) cylinder(d = connectorDia, h = 6);
        
        // nut cutout
        translate([0, 0, 1]) nutTrap(diameter = connectorNutDia, height = 6);
    }
}

connectorCase();