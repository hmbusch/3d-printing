/**
 * Extended (22mm) Camera Plates for Toad90 Frame
 *
 * by Hendrik Busch, 2018 (https://github.com/hmbusch)
 *
 * The Eachine stack that I put into my Toad90 was prone to
 * vibrations from the motors. After I soft-mounted the FC,
 * the 20mm height inside the frame was to small so I increased
 * it to 22mm with some washer. I also needed to elongate the
 * camera mounting plates and designed these. They fit very well
 * and even offer a little bit more tilt than the original ones.
 *
 * Note: rendering this file might take a while due to the curved
 * slot for the camera tilt.
 */
$fn = 64;

module camPlate() {
    difference() {
        union() {
            // main plate
            cube([22, 10, 1.4]);
            
            // top and bottom fins
            translate([22, 2.5, 0]) cube([1.6, 6, 1.4]);
            translate([-1.6, 2.8, 0]) cube([1.6, 5.5, 1.4]);
            
            // pivot point mount
            hull() {
                translate([10, 9.5, 0]) cylinder(d = 4, h = 1.4);
                translate([9, 12, 0]) cylinder(d = 6, h = 1.4);
                translate([2, 10, 0]) cylinder(d = 4, h = 1.4);
            }
            
            // slot mount
            hull() {
                translate([19, 12, 0]) cylinder(d = 6, h = 1.4);
                translate([11, 10, 0]) cylinder(d = 3, h = 1.4);
                translate([20, 9.5, 0]) cylinder(d = 4, h = 1.4);
            }
        }
        // pivot hole
        translate([9, 12, -0.01]) cylinder(d = 2.2, h = 1.42);
        
        // slot holes
        translate([9, 12, -0.01]) {
            for(angle = [0 : -0.5 : -50]) {
                rotate([0, 0, angle]) translate([10, 0, 0]) cylinder(d = 2.2, h = 1.42, $fn = 16);
            }
        }
    }
}

translate([0, 2, 0]) camPlate();
translate([0, -2, 0]) mirror([0, 1, 0]) camPlate();
