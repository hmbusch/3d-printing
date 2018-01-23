/*
 * This part is intended for the Toad90 FPV quadcopter frame.
 * The frame is so small that it offers no real place to mount
 * an LED. This part is designed to fit around the back standoffs
 * and offers a mounting position of a single Neopixel/WS2812 LED.
 * The cables can be fed through the cable slot behind the LED.
 *
 * I strongly recommend that you glue the LED in place after
 * testing. The props pass very near to the holder and if the
 * LED comes loose, it will almost certainly be ripped of by
 * the props (I'm talking from experience).
 *
 * "Toad90 LED mount"
 * by Hendrik Busch is licensed under a 
 * 
 * Creative Commons Attribution-ShareAlike 4.0 International License.
 */
$fn = 128;

difference() {
    union() {
        difference() {
            translate([0, 4.9, 5+7]) rotate([90, 0, 0]) cylinder(d = 12, h = 3);
            color("gray") translate([0, 4.91, 12]) rotate([90, 0, 0]) cylinder(d = 10, h = 1.75);
            translate([-5.5/2, 0, 8]) cube([5.5, 4, 3]);
        }

        difference() {
            translate([-5, 0, 0]) cylinder(d = 3.5 + 2, h = 20);
            translate([-5, 0, -0.1]) cylinder(d = 3.7, h = 20.2);
            
        }

        difference() {
            translate([5, 0, 0]) cylinder(d = 3.5 + 2, h = 20);
            translate([5, 0, -0.1]) cylinder(d = 3.7, h = 20.2);
        }
        translate([-2.5, -1, 12]) cube([5,2,5]);
        
    }
    translate([8.5, 0, 10]) cube([6, 12, 20.2], center = true);
    translate([-8.5, 0, 10]) cube([6, 12, 20.2], center = true);
    //translate([-7.25, -1.1, 10]) rotate([0, 0, 30]) cube([6, 6, 20.2], center = true);
}