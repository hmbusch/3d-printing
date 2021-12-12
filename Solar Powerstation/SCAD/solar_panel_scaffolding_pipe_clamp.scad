include <../../Various/SCAD/screw_holes.scad>;

pipe_diameter = 42;
pipe_clamp_strength = 10;
pipe_clamp_screw_diameter = 10;
pipe_clamp_nut_height = 9;
pipe_clamp_nut_width = 17.2;
pipe_clamp_gap = 0.2;

connector_height = 60;
connector_width = 40;
connector_spacing = 125;
connector_thickness = 16;
connector_screw_diameter = 8.2;
connector_mating_height = 80;
connector_screw_hole_slot_size = 16;

// derived values
pipe_clamp_outer_diameter = pipe_diameter + pipe_clamp_strength * 2;

// other settings
$fn = 128;

f = 0.01;
df = 2 * f;

difference() {
    
    // clamp body w/ connector
    union() {        
        cylinder(d = pipe_clamp_outer_diameter, h = connector_height);
        hull() {
            translate([0, -pipe_clamp_outer_diameter/2, 0])
                cube([1, pipe_clamp_outer_diameter, connector_height]);
            translate([connector_spacing - connector_width - 1, -pipe_clamp_outer_diameter/2, 0])
                cube([1, pipe_clamp_outer_diameter, connector_height]);
            translate([connector_spacing - 1 - connector_width/2, -pipe_clamp_outer_diameter/2, 0])
                cube([1, pipe_clamp_outer_diameter, connector_thickness]);
        }        
        hull() {
            translate([connector_spacing - connector_width, -pipe_clamp_outer_diameter/2, 0])
                cube([1, pipe_clamp_outer_diameter, connector_thickness]);
            translate([connector_spacing - connector_width/2, -connector_mating_height/2, 0])
                cube([connector_width, connector_mating_height, connector_thickness]);
        }
    }
    
    // hole for pipe
    translate([0, 0, -f])
        cylinder(d = pipe_diameter, h = connector_height + df);
    
    // split into two parts
    translate([-pipe_clamp_outer_diameter/2, -pipe_clamp_gap/2, -f])
        cube([pipe_clamp_outer_diameter * 1.5, pipe_clamp_gap, connector_height + df]); 
    translate([pipe_clamp_outer_diameter, -pipe_clamp_gap/2, -f]) 
        cube([pipe_clamp_gap, pipe_clamp_outer_diameter/2 + pipe_clamp_gap, connector_height + df]);

    // screw holes for clamp
    for(z_offset = [pipe_clamp_strength * 1.5, connector_height - pipe_clamp_strength * 1.5]) {
        translate([pipe_diameter/2 + 2 * pipe_clamp_strength, pipe_clamp_outer_diameter/2 + f, z_offset])
            rotate([90, 0, 0]) {
                cylinder(d = pipe_clamp_screw_diameter, h = pipe_clamp_outer_diameter + df);
                nut_trap(pipe_clamp_screw_diameter, pipe_clamp_nut_width, 0, pipe_clamp_nut_height);
            }
    }  
  
    // screw holes for connector
    for(y_offset = [connector_mating_height/4, -connector_mating_height/4]) {
    hull() {
        translate([connector_spacing, y_offset + connector_screw_hole_slot_size/2, -f])
            cylinder(d = connector_screw_diameter, h = connector_thickness + df);
        translate([connector_spacing, y_offset - connector_screw_hole_slot_size/2, -f])
            cylinder(d = connector_screw_diameter, h = connector_thickness + df);
    }
} 
}

   