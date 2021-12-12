inner_width = 20;
inner_length = 37;
inner_height = 10;
wall_thickness = 3;
cutout_xt60_width = 15.8;
cutout_xt60_height = 8.2;
cutout_wires_width = 17.8;
cutout_wires_height = 6;

outer_width = inner_width + 2 * wall_thickness;
outer_length = inner_length + 2 * wall_thickness;
outer_height = inner_height + wall_thickness;

difference() {
    cube([outer_length, outer_width, outer_height]);
    translate([wall_thickness, wall_thickness, wall_thickness])
        cube([inner_length, inner_width, inner_height]);
    translate([0, (outer_width - cutout_wires_width) / 2, outer_height - cutout_wires_height])
        cube([wall_thickness, cutout_wires_width, cutout_wires_height]);
    translate([outer_length - wall_thickness, (outer_width - cutout_xt60_width) / 2, outer_height - cutout_xt60_height])
        cube([wall_thickness, cutout_xt60_width, cutout_xt60_height]);
    
}

translate([0, 1.2 * outer_width, 0])
    cube([outer_length, outer_width, wall_thickness]);