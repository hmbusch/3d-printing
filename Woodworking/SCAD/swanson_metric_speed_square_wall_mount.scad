// Swanson Metric Speed Square Wall Mount

cutout_height = 7.5;
cutout_width = 129;
tool_distance = 10;
tool_thickness = 6;
wall_distance = tool_distance + tool_thickness;
wall_offset = 3;
$fn = 64;

module hanger() {
    difference() {
        translate([cutout_height/2, cutout_height/2, 0])
        hull() {
            cylinder(d = cutout_height, h = wall_distance + wall_offset);
            translate([cutout_width - cutout_height, 0, 0]) 
                cylinder(d = cutout_height, h = wall_distance + wall_offset);
        }
        translate([0, cutout_height - wall_offset/2, 0])
            cube([cutout_width, wall_offset/2, wall_distance]);
    }
}


module screw() {
    rotate([0, 180, 0]) {
        cylinder(d=3.2, h=tool_distance + tool_thickness + wall_offset + 0.1);
        cylinder(d1=7.5, d2=3.2, h=3);
    }
}

difference() {
    hanger();
    translate([cutout_height/2, cutout_height/2 -0.5, wall_distance + wall_offset])
        screw();
    translate([cutout_width - cutout_height/2, cutout_height/2 -0.5, wall_distance + wall_offset])
        screw();
    translate([cutout_width/2, cutout_height/2 -0.5, wall_distance + wall_offset])
        screw();
    
}