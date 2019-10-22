/**
 * Extruder Wire Harness Mount for AM8 Variant
 *
 * by Hendrik Busch, 2017 (https://github.com/hmbusch)
 *
 * inspired by 
 *        2020 Cable Zip Tie Mount by joochung 
 *        http://www.thingiverse.com/thing:2308406
 *
 * My AM8 variant uses the Prusa i3 MK2S extruder. The wire
 * harness coming from this extruder is supported by a length
 * of nylon 3mm filament so that the wires don't sag.
 * This part is intended to mount onto the horizontal extrusion
 * on the electronics side. It offers a ziptie mountpoint for
 * all the wires and a hole for the nylon filament to go into.
 *
 * To be used with an M5x10 button head screw and a ziptie 
 * up to 5x2mm in size.
 */
use <rounded_box.scad>

$fn = 128;

module half_torus_with_ziptie() {
    translate([0, 0, 8.5]) difference() {
        rotate([90, 0, 0]) cylinder(d = 17, h = 18);
        rotate([90, 0, 0]) cylinder(d = 11, h = 18);
        translate([-9, -18, 0]) cube([18, 18, 9]);
        translate([-9, -11.5, -4.5]) cube([18, 5, 2]);
    }
}

module mount_main_body() {
    difference() {
        union() {
            difference() {
                box_with_round_edges(width = 20, depth = 30, height = 7, edge_radius = 5);
                translate([10, 19, 11.5]) rotate([90, 0, 0]) cylinder(d = 11, h = 18);
            }
            translate([10, 19, 3]) half_torus_with_ziptie();
            // support for nylon wire harness support
            translate([10, 35, 3.5]) rotate([90, 0, 0]) cylinder(r1 = 2.5, r2 = 3.5, h = 5);
        }
        
        // hole for nylon wire harness support
        translate([10, 36, 3.5]) rotate([90, 0, 0]) cylinder(r = 1.52, h = 19);
        
    }
}

module 2020_extruder_cable_harness_mount() {
    union() {
        difference() {
            mount_main_body();
            translate([10, 10, -1]) cylinder(d = 5.2, h = 10);
            translate([10, 10, 4.5]) cylinder(d = 9.5, h = 5);
        }    
        // add fins for proper alignment
        translate([7.5, 0, -2]) cube([5, 4, 2]);
        translate([7.5, 20, -2]) cube([5, 10, 2]);
    }
}

module 2020_heatbed_cable_harness_mount() {
    union() {
        difference() {
            mount_main_body();
            translate([10, 10, -1]) cylinder(d = 5.2, h = 10);
            translate([10, 10, 4.5]) cylinder(d = 9.5, h = 5);
        }    
        // add fins for proper alignment
        translate([20, 0, 0]) rotate([0, 0, 90]) {
            translate([7.5, 0, -2]) cube([5, 4, 2]);
            translate([7.5, 16, -2]) cube([5, 4, 2]);
        }
    }
}

2020_extruder_cable_harness_mount();
translate([30, 0, 0]) 2020_heatbed_cable_harness_mount();