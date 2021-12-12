$fn = 64;

thickness = 10;

module side_part() {
    hull() {
        translate([0, 10, 0])
            cube([10, 30, thickness]);
        translate([10 + 10/2, 40 - 10/2, 0])
            cylinder(d = 10, h = thickness);
        translate([10, 10, 0])
            cube([10, 20, thickness]);
    }
}

module middle_part() {
    difference() {
        translate([0, 10, 0])
            cube([100, 30, thickness]);
        hull() {
            translate([10/2, 30 + 10/2, -1])
                cylinder(d = 10, h = thickness * 2);
            translate([100 - 10/2, 30 + 10/2, -1])
                cylinder(d = 10, h = thickness * 2);
            translate([0, 40, -1])
            cube([100, 10, thickness * 2]);
        }
    }
}

module screw() {
    cylinder(d = 3.2, h = thickness);
    translate([0, 0, 8])
        cylinder(d1 = 3.2, d2 = 7, , h = 2);
}

difference() {
    union() {
        side_part();
        translate([140, 0, 0])
            mirror([1, 0, 0])
                side_part();
        translate([20, 0, 0])
            middle_part();
    }
    translate([15, 35, 0])
        screw();
    translate([125, 35, 0])
        screw();
    translate([45, 20, 0])
        screw();
    translate([95, 20, 0])
        screw();
    translate([140/2 - 0.5, 10, 0])
        cube([1, 3, thickness]);
    
}