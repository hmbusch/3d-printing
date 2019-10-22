armSpacing = 77.5;
mountHeight = 2;
$fn = 64;



module motorPlate() {
    difference() {
        cylinder(d = 14, h = mountHeight);
        translate([0, 0, -0.1]) cylinder(d = 5, h = mountHeight + 0.2);
        for(angle = [0, 90, 180, 270]) {
            rotate([0, 0, angle]) hull() {
                translate([-4.8, 0, -0.1]) cylinder(d = 2.1, h = mountHeight + 0.2);
                translate([-4.3, 0, -0.1]) cylinder(d = 2.1, h = mountHeight + 0.2);
            }
        }
        
    }
}

module rxAntennaMount() {
    translate([-armSpacing/2, 0, 0]) motorPlate();
    translate([armSpacing/2, 0, 0]) motorPlate();
    translate([-armSpacing/2 + 6, -2, 0])cube([armSpacing -12 , 4, mountHeight]);
    translate([-armSpacing/2 + 2, 0, 0]) rotate([0, 0, 45]) difference() {
        cube([22, 4, mountHeight]);
        translate([-1.4, 1.4, -0.1]) cylinder(d = 13, h = mountHeight + 0.2);
    }
    translate([armSpacing/2 - 2, 7, 0]) rotate([0, 0, -45]) difference() {
        cube([22, 4, mountHeight]);
        translate([-1.4, 1.4, -0.1]) cylinder(d = 13, h = mountHeight + 0.2);
    }
}

rxAntennaMount();
