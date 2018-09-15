/**
 * Spacer for Malm drawer
 *
 * In my IKEA malm drawer cabinet, I installed a second, removable
 * bottom in one of the drawers to make better use of the space. 
 * This second bottom rests on four of these spacers. The feature a lip
 * on two sides that slides into the slots of the drawer in each 
 * corner. For additional support, up to two screws can be used
 * to fixate the spacers against the drawer frame.
 *
 * Copyright of this design 2018, Hendrik Busch
 * https://github.com/hmbusch
 *
 * Licensed under Creative Commons Attribution Share Alike 4.0.
 * https://creativecommons.org/licenses/by-sa/4.0/
 */

$fn = 64;

difference() {
    union() {
        cube([25, 25, 0.4]);
        cube([20, 20, 50]);
    }
    translate([-1, 10, 40]) rotate([0, 90, 0]) cylinder(d = 3.2, h = 22);
    translate([-0.1, 10, 40]) rotate([0, 90, 0]) color("green") cylinder(d1 = 6.1, d2 = 3.2, h = 2.7);
    
    translate([10, -1, 20]) rotate([-90, 0, 0]) cylinder(d = 3.2, h = 22);
    translate([10, -0.1, 20]) rotate([-90, 0, 0]) color("green") cylinder(d1 = 6.1, d2 = 3.2, h = 2.7);
}