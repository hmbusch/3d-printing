include <gopro-mount-library.scad>

mount_type = "screw"; // gopro_camera, gopro_tripod, screw

strut_thickness = 4; // 8 for large, 4 for very small
strut_width = 6; // 10 for large, 6 for very small

hole_spacing_x = 50; // 111 for small, 160 for large, 50 for very small
hole_spacing_y = 50; // 117.5 for small, 160 for large, 50 for very small

center_mount = "no"; // yes, no
center_dia = 30;

fan_holes = "40x40"; // 40x40, 80x80, 120x120, no

// This takes a 3/8" thread that will cut its way through the plastic, 
// therefore the diameter needs to be smaller
center_screw_hole_dia = 8.25;

screw_hole_dia = 3.2;
screw_head_dia = 7;

f = 0.01;

$fn = 128;

overhang_y = 21; // 20 for small, 21 for large, 10 for very small

reinforcement_factor = 1.5;

// Derived values, do not edit

hsxh = hole_spacing_x / 2;
hsyh = hole_spacing_y / 2;

strut_length_y = hole_spacing_y + overhang_y;
slyh = strut_length_y / 2; 

df = 2 * f;

module quarter_ball(d = 2 * center_screw_hole_dia + 4 * strut_thickness) {
    rotate_extrude(angle = 90, convexity = 10)
        difference() {
            circle(d = d);
            translate([0, -d/2])
                square([d/2, d]);
        }
}

module brace_body() {
    // right strut
    hull() {
        translate([hsxh, slyh, 0])
            cylinder(d = strut_width, h = strut_thickness * reinforcement_factor);
        translate([hsxh, -hsyh, 0])
            cylinder(d = strut_width, h = strut_thickness);
    }

    // left strut
    hull() {
        translate([-hsxh, slyh, 0])
            cylinder(d = strut_width, h = strut_thickness * reinforcement_factor);
        translate([-hsxh, -hsyh, 0])
            cylinder(d = strut_width, h = strut_thickness);
    }

    // rear strut
    hull() {
        translate([hsxh, slyh, 0])
            cylinder(d = strut_width, h = strut_thickness * reinforcement_factor);
        translate([-hsxh, slyh, 0])
            cylinder(d = strut_width, h = strut_thickness * reinforcement_factor);
    }


    // front strut
    hull() {
        translate([hsxh, -hsyh, 0])
            cylinder(d = strut_width, h = strut_thickness);
        translate([-hsxh, -hsyh, 0])
            cylinder(d = strut_width, h = strut_thickness);
    }

    // crossbrace 1
    hull() {
        translate([-hsxh, hsyh, 0])
            cylinder(d = strut_width, h = strut_thickness);
        translate([hsxh, -hsyh, 0])
            cylinder(d = strut_width, h = strut_thickness);
    }

    // crossbrace 2
    hull() {
        translate([-hsxh, -hsyh, 0])
            cylinder(d = strut_width, h = strut_thickness);
        translate([hsxh, hsyh, 0])
            cylinder(d = strut_width, h = strut_thickness);
    }
    
    // side brace
    hull() {
        if (center_mount == "yes") {
            translate([0, center_dia/2, 0])
                cylinder(d = strut_width, h = strut_thickness);
        } else {
            cylinder(d = strut_width, h = strut_thickness);
        }
        translate([0, slyh, 0])
        if (mount_type == "gopro_camera" || mount_type == "gopro_tripod") {
            cylinder(d = strut_width, h = gopro_flap_depth);
        } else {
            cylinder(d = strut_width, h = strut_thickness * reinforcement_factor);
        }
    }
    
    // side mount
    translate([0, slyh + strut_width/2, 0])
        if(mount_type == "gopro_camera") {
            hull() {
                translate([gopro_camera_width/2, 0, gopro_flap_depth/2])
                    rotate([90, 0, 0])
                        cylinder(d = gopro_flap_depth, h = strut_width);
                translate([-gopro_camera_width/2, 0, gopro_flap_depth/2])
                    rotate([90, 0, 0])
                        cylinder(d = gopro_flap_depth, h = strut_width);
                cube_x = gopro_camera_width + gopro_flap_depth * reinforcement_factor;
                translate([-cube_x/2, - strut_width, 0])
                    cube([cube_x, strut_width, strut_thickness * reinforcement_factor]);
            }
        } else if(mount_type == "gopro_tripod") {
            hull() {
                translate([gopro_tripod_width/2, 0, gopro_flap_depth/2])
                    rotate([90, 0, 0])
                        cylinder(d = gopro_flap_depth, h = strut_width);
                translate([-gopro_tripod_width/2, 0, gopro_flap_depth/2])
                    rotate([90, 0, 0])
                        cylinder(d = gopro_flap_depth, h = strut_width);
                cube_x = gopro_tripod_width + gopro_flap_depth * reinforcement_factor;
                translate([-cube_x/2, - strut_width, 0])
                    cube([cube_x, strut_width, strut_thickness * reinforcement_factor]);
            }
            
        }
        else {
            rotate([0, 90, 0]) {
                ball_dia = 2 * center_screw_hole_dia + 4 * strut_thickness;
                quarter_ball(ball_dia);
            }
        }

    if (center_mount == "yes") {
        // center
        cylinder(d = center_dia, h = strut_thickness);
    }
        
    // optional GoPro mountpoints
    if (mount_type == "gopro_camera") {
        translate([gopro_flap_width + gopro_flap_spacing/2, slyh + strut_width/2, gopro_flap_depth/2])
        rotate([0, 90, 180])
            gopro_mount_camera_side();
    } else if (mount_type == "gopro_tripod") {
        translate([gopro_tripod_width/2, slyh + strut_width/2, gopro_flap_depth/2])
        rotate([0, 90, 180])
            gopro_mount_tripod_side();
    }
}

module hole_pattern(x, y, dia, h, z = -f, z2 = 0) {
    alt_z = z2 > 0 ? z2 : z;
    translate([x, y, alt_z])
        cylinder(d  = dia, h = h);
    translate([-x, y, alt_z])
        cylinder(d  = dia, h = h);
    translate([x, -y, z])
        cylinder(d  = dia, h = h);
    translate([-x, -y, z])
        cylinder(d  = dia, h = h);
}

module brace() {
    difference() {
        brace_body();
        
        if (center_mount == "yes") {
            // center mounting hole
            translate([0, 0, -f])
                cylinder(d = center_screw_hole_dia, h = strut_thickness * reinforcement_factor + df);
        }
            
        // screw head (for flush mounting)
        if (reinforcement_factor > 1) {
            hole_pattern(hsxh, hsyh, screw_head_dia, strut_thickness, strut_thickness - f, strut_thickness * reinforcement_factor * 0.95);
        }

        // screw holes
        hole_pattern(hsxh, hsyh, screw_hole_dia, strut_thickness * 2);

        // additional fan mounting holes
        if (fan_holes == "40x40") {
            hole_pattern(32/2, 32/2, screw_hole_dia, strut_thickness * 2);
        } else if (fan_holes == "80x80") {
            hole_pattern(71.5/2, 71.5/2, 4.5, strut_thickness * 2);
        } else if (fan_holes == "120x120") {
            hole_pattern(105/2, 105/2, 4.5, strut_thickness * 2);
        }
        
        // side mounting hole
        if (mount_type == "screw") {
            color("red")
            translate([0, slyh - strut_width + f, strut_thickness + center_screw_hole_dia/2])
                rotate([0, 90, 90])
                    cylinder(d = center_screw_hole_dia, h = strut_width * 1.5);                      
        }
    }
}

brace();