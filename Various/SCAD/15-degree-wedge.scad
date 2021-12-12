module triangle() {
    difference() {
        union() {
            difference() {
                union() {
                    cube([50, 5, 5]);

                    rotate([0, -15, 0])
                        translate([-20, 0, 0])
                            cube([80, 5, 5]);
                }
                translate([50, 0, 0])
                    cube([10, 5, 50]);
                
                translate([-25, 0, -10])
                    cube([50, 5, 10]);
            }
            translate([50, 0, 0])
                cube([5, 5, 20]);
        }
        rotate([0, -15, 0])
            translate([0, 0, 5])
                cube([80, 5, 5]);
    }
}

module wedge() {
    triangle();
    translate([0, 100, 0])
        triangle(); 
    translate([50, 0, 0])
        cube([5, 100, 5]);
    translate([10, 0, 0])
        cube([5, 100, 5]);    
}


wedge();