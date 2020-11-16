include <gopro-mount-library.scad>

shoe_x = 25;
shoe_y = 20;
shoe_z = 7;

module cold_shoe_nut_trap(head_width, h ) {
    cylinder(r = w / 2 / cos(180 / 6) + 0.05, h=h, $fn=6);
    
}

module cold_shoe_cutout(y = shoe_y) {
    cube([18.9, y, 2.6]);
    translate([(18.9-12.4)/2, 0, 2.6])
        cube([12.4, y, 1.5]);
}

module cold_shoe() {
    difference() {
        cube([shoe_x, shoe_y, shoe_z]);
        translate([(shoe_x-18.9)/2, 0, shoe_z - 1.5 - 2.6 + 0.01])
            cold_shoe_cutout();
    }
}

module gopro_cold_shoe() {
    cold_shoe();
    hull() {
        cube([shoe_x, shoe_y, 0.01]);
        translate([(shoe_x - gopro_camera_width)/2, (shoe_y - gopro_flap_depth)/2, -5])
            cube([gopro_camera_width, gopro_flap_depth, 5]);
    }
    translate([(shoe_x - gopro_camera_width)/2, shoe_y/2, -5])
        rotate([90, 0, 90])
            gopro_mount_camera_side();
}

gopro_cold_shoe();