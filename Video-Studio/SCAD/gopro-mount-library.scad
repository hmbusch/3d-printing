$fa = 2;
$fs = 0.25;
gopro_extra_mount_depth = 3;
gopro_flap_width = 3;
gopro_flap_with_nut_width = gopro_flap_width + 5;
gopro_flap_depth = 15;
gopro_flap_extra_depth = 2;
gopro_flap_spacing = 3;
gopro_screw_dia = 5.2;

gopro_tripod_width = gopro_flap_with_nut_width + 2 * gopro_flap_width + 2 * gopro_flap_spacing;
gopro_camera_width = 2 * gopro_flap_width + gopro_flap_spacing;

// derived values

gfdh = gopro_flap_depth/2;
nh = gopro_flap_with_nut_width - gopro_flap_width;



module gopro_nut_hole() {
    for(i = [0, 120, 240]) {
        rotate([0, 0, i])
            cube([4.6765, 8.1, nh], center = true);
    } 
}

module gopro_flap(width = gopro_flap_width) {
    difference() {
        union() {
            cylinder(d = gopro_flap_depth, h = width);
            translate([-gfdh, 0, 0])
                cube([gopro_flap_depth, gopro_flap_depth - gfdh + gopro_flap_extra_depth, width]);
        }
        translate([0, 0, -0.01])
            cylinder(d = gopro_screw_dia, h = width + 0.02);
    } 
}

module gopro_mount_camera_side() {
    translate([0, - gfdh - gopro_flap_extra_depth, 0]) {
        
        gopro_flap();
        translate([0, 0, gopro_flap_width + gopro_flap_spacing])
            gopro_flap();
    }
}

module gopro_mount_tripod_side() {
    translate([0, - gfdh - gopro_flap_extra_depth, 0]) {
        difference() {
            gopro_flap(gopro_flap_with_nut_width);
            translate([0, 0, nh/2 - 0.01])
                gopro_nut_hole();
        }
    }
    translate([0, 0, gopro_flap_with_nut_width + gopro_flap_spacing])
        gopro_mount_camera_side();    
}