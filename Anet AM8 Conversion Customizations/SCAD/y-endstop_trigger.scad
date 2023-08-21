$fn = 128;

module size1() {
    difference() {
        hull() {
            cube([32, 10, 14]);
            translate([37, 3.5, 0]) cube([2, 3, 14]);
        }
        for (offset = [0, 6, 12]) {
            translate([offset + 3.5, 5, 0]) cylinder(d = 3.3, h = 14);
            translate([offset + 3.5, 5, 7]) cylinder(d = 5, h = 7);
            translate([offset + 21.5, 5, 0]) cylinder(d = 3.3, h = 14);    
            translate([offset + 21.5, 5, 7]) cylinder(d = 5, h = 7);    
        }
    }
}

module size2() {
    difference() {
        hull() {
            cube([26, 10, 14]);
            translate([31, 3.5, 0]) cube([2, 3, 14]);
        }
        for (offset = [0, 6, 12, 18, 24]) {
            translate([offset + 3.5, 5, 0]) cylinder(d = 3.3, h = 14);
            translate([offset + 3.5, 5, 7]) cylinder(d = 5, h = 7);
        }
    }    
}

module size3() {
    difference() {
        hull() {
            translate([6, 0, 0]) cube([20, 10, 14]);
            translate([31, 3.5, 0]) cube([2, 3, 14]);
        }
        for (offset = [6, 12, 18, 25]) {
            translate([offset + 3.5, 5, 0]) cylinder(d = 3.3, h = 14);
            translate([offset + 3.5, 5, 7]) cylinder(d = 5, h = 7);
        }
    }    
}

size1();
translate([0, 15, 0]) size2();
translate([-6, 30, 0]) size3();