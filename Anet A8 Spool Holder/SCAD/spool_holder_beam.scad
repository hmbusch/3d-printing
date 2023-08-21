/* [Beam] */

// How wide should the beam be?
beamWidth = 130;

// How large should the center cutout be (in %/100)?
cutoutPercentage = 0.8; // [0:1]

/* [Hidden] */

availableSpace = (beamWidth - 55) * cutoutPercentage;
cutoutOffset = (beamWidth - 55 - availableSpace) / 2 + (55/2);

module beamBody() {
    difference() {
        cube([beamWidth, 30, 5]);
        translate([0 - 0.01, 15, 0]) screwAndNutCutout();
        translate([beamWidth + 0.01, 15, 0]) rotate([0, 0, 180]) screwAndNutCutout();    
        translate([cutoutOffset, 15, 0]) centerCutout();
    }
}

module screwAndNutCutout() {
    translate([0, -5, 0]) union() {
        cube([5, 10, 5]);
        translate([5, 5 - 3.3/2, 0]) cube([14, 3.3, 5]);
        translate([9, 5 - 5.6/2, 0]) cube([3, 5.6, 5]);
    }
}

module centerCutout() {
    if (cutoutPercentage > 0) {        
        hull() {
            cylinder(d = 15, h = 5);
            translate([availableSpace, 0, 0]) cylinder(d = 15, h = 5);
        }
    }
}

beamBody();