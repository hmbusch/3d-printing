$fn = 32;

difference() {
    cube([12, 5, 10]);

    translate([2, 5/2, -1]) {     
        for(offset = [0:3]) {
            translate([offset * 2.54, 0, 0])
                cylinder(d = 1.6, h = 20);
        }
    }
}
