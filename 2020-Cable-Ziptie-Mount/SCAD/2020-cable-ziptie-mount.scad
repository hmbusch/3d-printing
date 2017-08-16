/**
 * Cable Mount using a Ziptie for 2020 Extrusion Profiles
 *
 * by Hendrik Busch, 2017 (https://github.com/hmbusch)
 *
 * inspired by 
 *        2020 Cable Zip Tie Mount by joochung 
 *        http://www.thingiverse.com/thing:2308406
 *
 * I had to redo the original part because I only had M5x10
 * screws available and those would touch the extrusion before
 * clamping the mount.
 *
 * The hole is still suited for an M5 button head screw and the
 * ziptie slot measures 5x2mm.
 *
 * I added two additional versions with some fins to align the 
 * mount to the extrusion, although using the fins makes them
 * somewhat harder to print.
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
        box_with_round_edges(width = 20, depth = 20, height = 7, edge_radius = 5);
        translate([10, 19, 11.5]) rotate([90, 0, 0]) cylinder(d = 11, h = 18);
    }
    translate([10, 19, 3]) half_torus_with_ziptie();
}

module 2020_cable_ziptie_mount() {
    difference() {
        mount_main_body();
        translate([10, 10, -1]) cylinder(d = 5.2, h = 10);
        translate([10, 10, 4.5]) cylinder(d = 9.5, h = 5);
    }    
}

module 2020_cable_ziptie_mount_with_hfins() {
    union() {
        2020_cable_ziptie_mount();
        translate([8, 0, -2]) cube([5, 4, 2]);
        translate([8, 16, -2]) cube([5, 4, 2]);
    }
}

module 2020_cable_ziptie_mount_with_vfins() {
    union() {
        2020_cable_ziptie_mount();
        translate([20, 0, 0]) rotate([0, 0, 90]) {
            translate([8, 0, -2]) cube([5, 4, 2]);
            translate([8, 16, -2]) cube([5, 4, 2]);
        }
    }
}

2020_cable_ziptie_mount();
translate([25, 0, 0]) 2020_cable_ziptie_mount_with_hfins();
translate([-25, 0, 0]) 2020_cable_ziptie_mount_with_vfins();