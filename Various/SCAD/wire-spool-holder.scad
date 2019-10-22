spoolDiameter = 90;
spoolWidth = 16.5;
spoolCount = 5;
seperatorWidth = 1.2;
standHeight = 30;
bottomThickness = 2;
gap = 0.5;
$fn = 128;

/*
 * derived values
 */
baseCutoutHeight = standHeight - bottomThickness - gap;
spoolChordSegmentAtStandHeight = 2 * sqrt(2 * (spoolDiameter/2 + gap) * baseCutoutHeight - pow(baseCutoutHeight, 2));
baseWidth = spoolChordSegmentAtStandHeight + 2 * seperatorWidth;
baseLength = spoolCount * (seperatorWidth + spoolWidth + 2 * gap) + seperatorWidth;

module spoolStand() {
    difference() {
        cube([baseLength, baseWidth, standHeight]);
        translate([seperatorWidth, 0, bottomThickness]) color("Silver") {
            for(i = [0 : spoolCount - 1]) {
                translate([i * (2 * gap + spoolWidth + seperatorWidth), 0, 0]) {
                    translate([0, baseWidth/2, spoolDiameter/2 + gap])
                    rotate([90, 0, 90]) 
                        cylinder(d = spoolDiameter + 2 * gap, h = spoolWidth + 2 * gap);
                } 
            }
        }
    }
}

spoolStand();