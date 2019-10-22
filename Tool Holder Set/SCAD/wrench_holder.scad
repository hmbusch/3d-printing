width_bottom = 50;
width_top = 100;
width_wall = 5;

height_holder = 150;
height_truss = 20;

depth_truss = 5;
depth_wall = 18;
depth_cutouts = 15;

height_cutouts = [ 5, 5, 5, 5, 5, 5, 5, 5, 6];
cutout_spacing = 10;

$fn=128;

module single_wall() {
    difference() {
        linear_extrude(height = depth_wall)
            polygon(points = [
                [width_bottom / 2, 0], 
                [width_wall + width_bottom / 2, 0], 
                [width_wall + width_top / 2, height_holder], 
                [width_top / 2, height_holder]
            ]);
        angled_width = cos(45) * depth_cutouts;
        for( pos = [0 : 8] ) {
            translate([0, cutout_spacing * 1.5 + pos * (cutout_spacing + angled_width / 2), 6])   
                rotate([45, 0, 0]) 
                    cube([width_top, height_cutouts[pos], depth_cutouts + depth_truss]);
        }
    }
}

module walls() {
    single_wall();
    mirror([1, 0, 0]) single_wall();
}

module screw_hole() {
    rotate([180, 0, 0]) cylinder(d=4.2, h=10);
    rotate([180, 0, 0]) cylinder(d=7.5, d2=4, h=3);
}

module trusses() {
    // some right angle triangle math...
    angle_alpha = acos((width_bottom / 2) / height_holder);
    offset= height_truss / tan(angle_alpha);
    difference() {
        linear_extrude(height = depth_truss) 
            polygon(points = [
                [width_bottom / 2, 0], 
                [- width_bottom / 2, 0], 
                [- (width_bottom / 2) - offset, height_truss], 
                [(width_bottom / 2) + offset, height_truss]
            ]);
        translate([0, height_truss / 2, depth_truss]) screw_hole();
    }
    difference() {
        wth = width_top / 2;
        wtho = wth - offset;
        linear_extrude(height = depth_truss)
            polygon(points = [
                [ wth, height_holder ],
                [ -wth, height_holder ],
                [ -wtho, height_holder - height_truss],
                [ wtho, height_holder - height_truss ]
            ]);
        translate([width_top / 3, height_holder - (height_truss / 2), depth_truss]) screw_hole();
        translate([- width_top / 3, height_holder - (height_truss / 2), depth_truss]) screw_hole();
    }
}

module base_body() {
    walls();
    trusses();
}

base_body();