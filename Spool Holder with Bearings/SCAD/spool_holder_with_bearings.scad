$fn = 64;

coneHeight = 25;
coneWidthBottom = 60;
coneWidthTop = 35;

rodDiameter = 8;
bearingDiameter = 22;
bearingHeight = 7;

bodyScrewHoleDepth = 12;
bodyScrewHoleDiameter = 2.5;

washerScrewHeadSize = 6;
washerScrewDiameter = 3;
washerHeight = 3;

centerOffset = bearingDiameter/2 + (coneWidthTop - bearingDiameter)/4;

print();
//assembly();

module print() {
    part_spoolCone();
    translate([coneWidthBottom / 2 + coneWidthTop/2 + 2, coneWidthTop / 2 + 1, 0]) part_washer();
    translate([coneWidthBottom / 2 + coneWidthTop/2 + 2, -(coneWidthTop / 2 + 1), 0]) part_washer();
}

module assembly() {
    color("SteelBlue") part_spoolCone();
    translate([0, 0, -washerHeight]) color("CadetBlue") part_washer();
    translate([0, 0, coneHeight + washerHeight]) rotate([0, 180, 0]) color("CadetBlue") part_washer();
}

module part_spoolCone() {
    difference() {
        cylinder(h = coneHeight, d1 = coneWidthBottom, d2 = coneWidthTop);
        cylinder(h = coneHeight, d = rodDiameter * 1.6);
        cylinder(h = bearingHeight + 0.1, d = bearingDiameter + 0.2);
        translate([0, 0, coneHeight - bearingHeight - 0.1]) cylinder(h = bearingHeight + 0.1, d = bearingDiameter + 0.2);
        for (angle = [0 : 90 : 360]) {
            rotate([0, 0, angle]) translate([centerOffset, 0, coneHeight - bodyScrewHoleDepth]) cylinder(d=bodyScrewHoleDiameter, h = bodyScrewHoleDepth);
            rotate([0, 0, angle]) translate([centerOffset, 0, 0]) cylinder(d = bodyScrewHoleDiameter, h = bodyScrewHoleDepth);
            rotate([0, 0, angle + 45]) translate([coneWidthBottom * 0.55, 0, 0]) cylinder(d = coneWidthBottom * 0.5, h = coneHeight);
        }
    }
}

module part_washer() {
    difference() {
        cylinder(h = washerHeight, d = coneWidthTop);
        translate([0, 0, washerHeight - 1]) cylinder(h = 1, d = bearingDiameter * 1.05);
        sub_sunkenWasherScrewHoles();
        cylinder(h = washerHeight, d = rodDiameter * 1.5);
    }
}

module sub_sunkenWasherScrewHoles() {
    for (angle = [0 : 90 : 360]) {
        rotate([0, 0, angle]) translate([centerOffset, 0, 0]) cylinder(d = washerScrewDiameter, h = washerHeight);
        rotate([0, 0, angle]) translate([centerOffset, 0, 0.5]) cylinder(d2 = washerScrewDiameter, d1 = washerScrewHeadSize + 0.1, h = washerScrewDiameter * 0.6);
        rotate([0, 0, angle]) translate([centerOffset, 0, 0]) cylinder(d = washerScrewHeadSize + 0.1, h = 0.5);
    }
}
