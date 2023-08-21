bit_count = 8;
bit_max_dia = 15;
bit_spacing = 2;

screw_shaft_dia = 3;
screw_head_dia = 6.2; // 6 + 0.2 slack
screw_head_angle_height = 2; // 1.8 + 0.2 slack

mounting_width = 14;

$fn = 32;

// derived values, do not edit
bar_width = ((bit_max_dia + bit_spacing) * bit_count) + 2 * max(bit_max_dia, mounting_width);
start_offset = max(bit_max_dia, mounting_width);

module mounting_bar() {
    difference() {
        hole_offset = start_offset / 3;
        cube([bar_width, bit_max_dia + 2 * bit_spacing, 10]);
        translate([hole_offset, bit_max_dia + 2 * bit_spacing, 5])
            mounting_screw(length = bit_max_dia + 2 * bit_spacing);
        translate([bar_width - hole_offset, bit_max_dia + 2 * bit_spacing, 5])
            mounting_screw(length = bit_max_dia + 2 * bit_spacing);
        
    }    
}    
    
module mounting_screw(length) {
    rotate([90, 0, 0]) {
        cylinder(d = screw_shaft_dia, h = length);
        translate([0, 0, length - screw_head_angle_height])
            cylinder(d2 = screw_head_dia, d1 = screw_shaft_dia, h = screw_head_angle_height + 0.01);
    }
}
    
module quarter_inch_hex_cutout(h = 1) {
    hex_width = 3.75;
    hex_length = 6.45;
    translate([0, 0, h/2]) {
        hull() {
            cube([hex_length, hex_width, h], center = true);
            rotate([0, 0, 60])
                cube([hex_length, hex_width, h], center = true);
            rotate([0, 0, 120])
                cube([hex_length, hex_width, h], center = true);
        }
    }
}

module bit_holder() {
    difference() {
        mounting_bar();
        for(i = [0:bit_count]) {
            translate([start_offset + i * (bit_max_dia + bit_spacing), (bit_max_dia + 2 * bit_spacing)/2, 3])
                quarter_inch_hex_cutout(h = 7.1);
            translate([start_offset + i * (bit_max_dia + bit_spacing) - 1, 0, 3])
                cube([2, (bit_max_dia + 2 * bit_spacing)/2, 7.1]);
        }
    }
}


bit_holder();