mirrored = 0;      // 1 = "right",  0 = "left"
height_m = 20;     //motor to hotend top. You may need to increase this for prometheus!

print();

module print() {    
    mirror ([mirrored, 0, 0]) {
        translate([0,-50,6]) rotate([-90, 0, 0])
        top_plate();
    }        
}

module top_plate() {
    difference() {
        union() {
            // Motor mounting plate
            hull() {
                translate([-14.5, 6, height_m+39.5]) rotate([-90, 0, 0]) cylinder(r=3, h=4, $fn=64);            
                translate([-18, 6, height_m+36]) rotate([-90, 0, 0]) cylinder(r=3, h=4, $fn=64);
                translate([-18, 6, height_m+29]) rotate([-90, 0, 0]) cylinder(r=3, h=4, $fn=64);
                translate([ 31/2, 6, height_m+37]) rotate([-90, 0, 0]) cylinder(r = 5.5, h=4, $fn=4);  
                translate([18, 6, height_m+29]) rotate([-90, 0, 0]) cylinder(r=3, h=4, $fn=64);
                translate([-25, 6, 44]) cube([5, 4, 22]);
            }
            // Connector from plate to mounting block
            translate([-26, 6, 44]) cube([5, 22, 22]);
            
            // Mounting block for 16mm tube
            translate([-44, 8, 55]) 
            union () {
                // mounting block base
                hull() {
                    translate([-4, 0, 0]) cylinder(r=2, h=10, $fn=64, center=true);
                    translate([18, 0, 0]) cube([4, 4, 10], center=true);
                    translate([-4, 18, 0]) cylinder(r=2, h=10, $fn=64, center=true);
                    translate([18, 18, 0]) cube([4, 4, 10], center=true);
                }
                //zip-tie block top
                difference() {
                    translate([13, 2, 5]) cube([5,14,6]);
                    translate([14.5, 1.9, 6]) cube([1.5,14.2,3.5]);
                }
                //zip-tie block bottom
                difference() {
                    translate([13, 5, -11]) cube([5,8,6]);
                    translate([14.5, 4.9, -10]) cube([1.5,8.2,3.5]);
                }
            }
        }

        // NEMA-17 motor cutout
        translate([0,10.1,height_m+21.5]) rotate([90,0,0]) cylinder(d=24, h=5, $fn=128);
            
        //mount hole (to motor)
        translate([-31/2, 5.9, height_m+37]) rotate([-90, 0, 0]) { 
            cylinder(r = 1.6, h = 5,  $fn=64);
            cylinder(r = 3.5, h = 2,  $fn=64);            
        }
        
        // mount hole (to motor/lever)
        translate([ 31/2, 5.9, height_m+37]) rotate([-90, 0, 0]) {
            cylinder(d = 3, h = 5,  $fn=64);
        }
        
        //tube hole
        translate([-39,17,55]) cylinder(d= 16, h=10.1, $fn=128, center=true);
        
        //cable slot
        translate([-39.5, 8, 55]) cube([6, 5, 10.1], center=true);
    }
}


