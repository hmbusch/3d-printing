centerHole = 7.6;
$fn=64;

module baseShape() {
    union() {
        hull() {
            for (angle = [0, 120, 240]) {
                rotate([0, 0, angle]) translate([0, 58, 0]) cube([30, 0.1, 6], center = true);
            }
        }
        translate([0, 0, 5.5]) cylinder(d = 10 + centerHole, h = 11, center = true);
    }
}

module m3Slot() {
    hull() {
        cylinder(d = 3.2, h = 8, center = true);
        translate([0, 13, 0]) cylinder(d = 3.2, h = 8, center = true);
    }
}

module triangleCutout() {
    rotate([0, 0, 30]) translate([17, 0, -4]) linear_extrude(height = 8) polygon(points = [[0, 0], [15, 26], [15, -26]]);
}

module spoolHolderHub() {
    difference() {
        baseShape();
        translate([0, 0, 9]) cylinder(d = centerHole, h = 4.01, center = true);
        for (angle = [0, 120, 240]) {
            rotate([0, 0, angle]) {
                translate([0, 15, 0]) m3Slot();
                translate([0, 37, 0]) m3Slot();
                triangleCutout();
            }
            
        }
    }
}

spoolHolderHub();

translate([100, 100, 0]) {
    difference() {
        cylinder(d = 10 + centerHole, h = 10);
        translate([0, 0, 6]) cylinder(d = centerHole, h = 4.01);
    }
}

