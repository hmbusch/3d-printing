vesa_distance = 75;
vesa_distance_half = vesa_distance / 2;
vesa_z_offset = -1;
screw_hole_d = 4.2;
screw_hole_od = 7.2;
$fn = 32;

module mounting_base_body() {

    vesa_h = 6;
    hull() {
        translate([-165/2, vesa_distance_half, vesa_z_offset]) cylinder(d=10, h=vesa_h);
        translate([165/2, vesa_distance_half, vesa_z_offset]) cylinder(d=10, h=vesa_h);
    }
    hull() {
        translate([-165/2, -vesa_distance_half, vesa_z_offset]) cylinder(d=10, h=vesa_h);
        translate([165/2, -vesa_distance_half, vesa_z_offset]) cylinder(d=10, h=vesa_h);
    }  
    hull() {
        translate([-165/2, -vesa_distance_half, vesa_z_offset]) cylinder(d=10, h=vesa_h);
        translate([165/2, vesa_distance_half, vesa_z_offset]) cylinder(d=10, h=vesa_h);
    }    
    hull() {
        translate([-165/2, vesa_distance_half, vesa_z_offset]) cylinder(d=10, h=vesa_h);
        translate([165/2, -vesa_distance_half, vesa_z_offset]) cylinder(d=10, h=vesa_h);
    }        
    hull() {
        translate([165/2, vesa_distance_half, vesa_z_offset]) cylinder(d=10, h=vesa_h);
        translate([165/2, -vesa_distance_half, vesa_z_offset]) cylinder(d=10, h=vesa_h);
    }    
    hull() {
        translate([-165/2, vesa_distance_half, vesa_z_offset]) cylinder(d=10, h=vesa_h);
        translate([-165/2, -vesa_distance_half, vesa_z_offset]) cylinder(d=10, h=vesa_h);
    }        
}

module mounting_base() {
    difference() {
        mounting_base_body();
        // top right
        translate([vesa_distance_half, vesa_distance_half, -1.1]) cylinder(d=screw_hole_d, h=3.1);
        translate([vesa_distance_half, vesa_distance_half, 0.9]) cylinder(d=screw_hole_od, h=4.2);
        // bottom left
        translate([-vesa_distance_half, -vesa_distance_half, -1.1]) cylinder(d=screw_hole_d, h=3.1);
        translate([-vesa_distance_half, -vesa_distance_half, 0.9]) cylinder(d=screw_hole_od, h=4.2);
        // bottom right
        translate([vesa_distance_half, -vesa_distance_half, -1.1]) cylinder(d=screw_hole_d, h=3.1);
        translate([vesa_distance_half, -vesa_distance_half, 0.9]) cylinder(d=screw_hole_od, h=4.2);
        // top left
        translate([-vesa_distance_half, vesa_distance_half, -1.1]) cylinder(d=screw_hole_d, h=3.1);    
        translate([-vesa_distance_half, vesa_distance_half, 0.9]) cylinder(d=screw_hole_od, h=4.2);    
    }
}

module receiver_mount() {
    // left brace
    translate([-0.5, -vesa_distance_half + 5, vesa_z_offset]) cube([5, vesa_distance + 10, 18 - vesa_z_offset]);
    translate([-0.5, -vesa_distance_half + 5, vesa_z_offset]) cube([5, 50, 38 - vesa_z_offset]);
    translate([-0.5, -vesa_distance_half, vesa_z_offset]) cube([10, 5, 38 - vesa_z_offset]);
    
    // right brace
    translate([77.5, -vesa_distance_half, vesa_z_offset]) cube([10, 5, 38 - vesa_z_offset]);
    translate([82.5, -vesa_distance_half + 5, vesa_z_offset]) cube([5, 50, 38 - vesa_z_offset]);
    translate([82.5, -vesa_distance_half + 5, vesa_z_offset]) cube([5, vesa_distance + 10, 18 - vesa_z_offset]);
    
    // top bar
    translate([-0.5, 7.5, 32 - vesa_z_offset]) cube([88, 10, 5]);
}

module battery_mount() {
    translate([-0.5, -66, vesa_z_offset]) cube([5, 115, 18]);
    translate([-35.5, -66, vesa_z_offset]) cube([35, 5, 25]);
    translate([-51.5, -50, vesa_z_offset]) cube([5, 100, 18]);
    
    translate([-0.5, -35, vesa_z_offset]) cube([5, 10, 34]);
    translate([-51.5, -35, vesa_z_offset]) cube([5, 10, 34]);
    translate([-51.5, -35, 28 - vesa_z_offset]) cube([56, 10, 5]);
    
    translate([-0.5, 25, vesa_z_offset]) cube([5, 10, 34]);
    translate([-51.5, 25, vesa_z_offset]) cube([5, 10, 34]);
    translate([-51.5, 25, 28 - vesa_z_offset]) cube([56, 10, 5]);
}

module velcro_hook() {
    cube([3, 3, 6]);
    translate([22, 0, 0]) cube([3, 3, 6]);
    translate([0, 0, 3]) cube([25, 3, 3]);
}

module receiver() {
    color("DarkGray", 0.8) cube([76, 84, 26]);
}

module battery() {
    color("MidnightBlue", 0.8) cube([44, 138, 22]);
    translate([0, 5, 13]) rotate([90, 0, 0]) color("Red", 0.8) cylinder(d=5, h=50);
    translate([0, 5, 7]) rotate([90, 0, 0]) color("Black", 0.8) cylinder(d=5, h=50);
}

module screen() {
    color("Black", 0.5) cube([182, 130, 5]);
}

union() {
    mounting_base();
    receiver_mount();
    battery_mount();
    translate([-80.5, 10, 5]) rotate([0, 0, 90]) velcro_hook();
    translate([-80.5, -35, 5]) rotate([0, 0, 90]) velcro_hook();
    translate([-51.5, 10, 15]) rotate([-90, 0, 90]) velcro_hook();
    translate([-51.5, -35, 15]) rotate([-90, 0, 90]) velcro_hook();
    
    %translate([6, -vesa_distance_half +6 , 6]) receiver();
    %translate([-45.5, -60, 6]) battery();
    %translate([-182/2, -130/2, -6]) screen();
} 
