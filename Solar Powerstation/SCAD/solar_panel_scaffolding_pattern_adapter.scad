include <../../Various/SCAD/screw_holes.scad>;

$fn = 64;

m6_y_spacing = 50;
m6_head_dia = 13.6;
m6_dia = 6.2;

adapter_x = 70;

f = 0.01;
df = 2 * f;

module mounting_adapter(mirrored = false) {
    adapter_x = 70;
    adapter_y = m6_y_spacing + m6_head_dia + 10;
    adapter_z = 14;
    
    hole_pattern_x_offset = 20;
    hole_pattern_y_offset = 5 + m6_head_dia/2;
    
    difference() {
        cube([adapter_x, adapter_y, adapter_z]);
        translate([hole_pattern_x_offset, hole_pattern_y_offset, -f])
            hole_pattern(14 + df, mirrored);
    }
    
}

module hole_pattern(h = 10, mirrored = false) {
    
    m6_head_dia = 13.6;
    m6_head_height = 5;
    m8_dia = 8.2;
    m8_x_spacing = 30;
    m8_x_offset = 7.5;
    m8_y_offset = 0.5;
    m8_nut_width = 13.2; 
    m8_nut_height = 6;
        
    cylinder(d = m6_dia, h = h);
    translate([0, 0, h - m6_head_height + f])
        cylinder(d = m6_head_dia, h = m6_head_height);
    translate([0, m6_y_spacing, 0]) {
        cylinder(d = m6_dia, h = h);
        translate([0, 0, h - m6_head_height + f])
            cylinder(d = m6_head_dia, h = m6_head_height);
    }

    if (mirrored)  {
        hull() {
            translate([m8_x_spacing - m8_x_offset, m6_y_spacing/2 + m8_y_offset, 0]) 
                cylinder(d = m8_dia, h = h);
            translate([m8_x_spacing + m8_x_offset, m6_y_spacing/2 - m8_y_offset, 0]) 
                cylinder(d = m8_dia, h = h);
        }  
        
        hull() {
            translate([m8_x_spacing - m8_x_offset, m6_y_spacing/2 + m8_y_offset, 0]) 
                nut_trap(m8_dia, m8_nut_width, 0, m8_nut_height);
            translate([m8_x_spacing + m8_x_offset, m6_y_spacing/2 - m8_y_offset, 0]) 
                nut_trap(m8_dia, m8_nut_width, 0, m8_nut_height);
        }
    } else {
        hull() {
            translate([m8_x_spacing - m8_x_offset, m6_y_spacing/2 - m8_y_offset, 0]) 
                cylinder(d = m8_dia, h = h);
            translate([m8_x_spacing + m8_x_offset, m6_y_spacing/2 + m8_y_offset, 0]) 
                cylinder(d = m8_dia, h = h);
        }  
        
        hull() {
            translate([m8_x_spacing - m8_x_offset, m6_y_spacing/2 - m8_y_offset, 0]) 
                nut_trap(m8_dia, m8_nut_width, 0, m8_nut_height);
            translate([m8_x_spacing + m8_x_offset, m6_y_spacing/2 + m8_y_offset, 0]) 
                nut_trap(m8_dia, m8_nut_width, 0, m8_nut_height);
        }
    }
        
}

mounting_adapter();
translate([adapter_x + 10, 0, 0])
    mounting_adapter(true);