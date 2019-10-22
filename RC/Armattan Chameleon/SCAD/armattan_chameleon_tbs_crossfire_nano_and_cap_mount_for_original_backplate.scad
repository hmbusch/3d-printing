slack = 0.1;

capDiameter = 13.2;
capRingWidth = 8;
capRingThickness = 2.4;

standoffWidth = 6.1;
standoffThickness = 4.2;
standoffTotalWidth = 30.5;

plateWidth = 35;
plateDepth = 35;
plateThickness = 2;
plateStandoffOffset = 2;

rxLength = 21;
rxWidth = 12;
rxBevelHeight = 4;
rxBevelWidth = 1;
rxRetentionBevelWidth = 4;
rxPlateOffset = 5.1;

module capRing() {
    rotate([0, 90, 0]) {
        difference() {
            // cap ring with mount plate
            hull(){
                translate([0, -2 * slack, 0]) cube([(capDiameter + capRingThickness)/2, capRingWidth, capRingWidth]);
                cylinder(d = capDiameter + capRingThickness, h = capRingWidth, $fn = 128);
            }
            // cap cutout
            translate([0, 0, -slack]) cylinder(d = capDiameter, h = capRingWidth + 2 * slack, $fn = 128);
        }
    }
}

module receiverBevels() {
    cube([rxLength, rxBevelWidth, rxBevelHeight]);
    translate([0, rxWidth + rxBevelWidth, 0]) cube([rxLength, rxBevelWidth, rxBevelHeight]);
    translate([0, rxWidth + rxBevelWidth - rxRetentionBevelWidth, 0]) cube([rxBevelWidth, rxRetentionBevelWidth, rxBevelHeight]);
    translate([rxLength, 0, 0]) cube([rxBevelWidth, rxRetentionBevelWidth, rxBevelHeight]);
}

module plate() {
    union() {
        difference() {
            // base plate
            cube([plateWidth, plateDepth, plateThickness]);
            
            // spacer cutouts
            standoffOffset = (plateWidth - standoffTotalWidth) / 2;
            translate([standoffOffset, plateStandoffOffset, -slack]) cube([standoffWidth, standoffThickness, plateThickness + 2 * slack]);
            translate([plateWidth - standoffOffset - standoffWidth, plateStandoffOffset, -slack]) cube([standoffWidth, standoffThickness, plateThickness + 2 * slack]);
        }
        
    }
}


totalBevelWidth = rxWidth + 2 * rxBevelWidth;
totalRingWidth = capDiameter + capRingThickness;
plateOffset = standoffThickness + 2 * plateStandoffOffset;

plate();
translate([(plateWidth - totalBevelWidth)/2 + totalBevelWidth - rxPlateOffset, plateOffset, plateThickness]) rotate([0, 0, 90]) receiverBevels();
translate([plateWidth - totalRingWidth/2, (plateDepth - capRingWidth + plateOffset)/2, totalRingWidth/2 + plateThickness - capRingThickness/2]) rotate([0, 0, 90]) capRing();