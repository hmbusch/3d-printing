/*
 * A model representation of the Eachine VTX-01 FPV
 * video transmitter. All measurements are to scale,
 * although the PCB and its components are only modeled
 * as a 3mm block, which is correct heightwise, but
 * doesn't reflect the component positions.
 *
 * "Eachine VTX-01 Model"
 * by Hendrik Busch is licensed under a 
 * 
 * Creative Commons Attribution-ShareAlike 4.0 International License.
 */
$fn = 64;

module vtx01() {
    // PCB (with approx. component height)
    color("DarkSlateGray") union() {
        translate([0, 0, -1]) cube([20, 14, 3]);
        translate([8, 14, 0]) cube([5.5, 5, 1]);
    }
    // 8-segment 
    color("Seashell") translate([0, 4.7, 2]) cube([7, 8, 2]);
    color("DimGray") translate([0, 4.7, 4]) cube([7, 8, 0.1]);

    // antenna connector
    color("gold") union() {
        translate([8 + (5.5/2 - 3/2), 14 + 4 - 3, 1]) cube([3, 3, 2.5]);
        translate([8 + (5.5/2 - 1.5/2), 14 + 4, 2]) cube([1.5, 2.5, 1.5]);
    }

    // antenna
    color("black") union() {
        translate([8 + 5.5/2, 20 + 26, 2.6]) rotate([90, 0, 0]) cylinder(d = 1.15, 26);
        translate([8 + 5.5/2, 20 + 26 + 2, 2.6]) rotate([90, 0, 0]) cylinder(d1 = 5, d2 = 3, 2);
        translate([8 + 5.5/2, 20 + 26 + 2 + 8, 2.6]) rotate([90, 0, 0]) cylinder(d = 5, 8);
        translate([8 + 5.5/2, 20 + 26 + 2 + 8 + 2, 2.6]) rotate([90, 0, 0]) cylinder(d1 = 3.4, d2 = 5, 2);
        translate([8 + 5.5/2, 20 + 26 + 2 + 8 + 2 + 7.3, 2.6]) rotate([90, 0, 0]) cylinder(d = 3.4, h = 7.3);
    }

    // cables
    color("red") translate([14, 1, 1.2]) rotate([90, 0, 0]) cylinder(d = 1, 12);
    color("black") translate([15.2, 1, 1.2]) rotate([90, 0, 0]) cylinder(d = 1, 12);
    color("red") translate([16.4, 1, 1.2]) rotate([90, 0, 0]) cylinder(d = 1, 10);
    color("black") translate([17.6, 1, 1.2]) rotate([90, 0, 0]) cylinder(d = 1, 10);
    color("yellow") translate([18.8, 1, 1.2]) rotate([90, 0, 0]) cylinder(d = 1, 10);

    // button
    color("Seashell") translate([1, 14 - 2.5, -2]) cube([4.51, 2.51, 2.5]);
    color("DimGray") translate([1 + 4.5/2 - 2/2, 14, -1.25]) cube([2, 1, 1]);
}

vtx01();