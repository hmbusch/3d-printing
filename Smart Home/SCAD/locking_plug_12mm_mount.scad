$fn = 64;

mount_depth = 30;
plug_diameter = 12;
lip_width = 7;
side_wall_strength = 1.2;
grommet_diameter = 7.5;
grommet_wall_strength = 1.2;
top_wall_strength = 3;

fudge = 0.01;

// Derived values, do not edit
pf = fudge;
nf = -fudge;
dpf = 2 * pf;
outer_diameter = plug_diameter + 2 * lip_width;

module mount() {
    difference() {
        
        union() {
            cylinder(d = outer_diameter, h = mount_depth);
            translate([-outer_diameter/2, 0, 0]) 
                cube([outer_diameter, outer_diameter/2, mount_depth]);
        }
        translate([0,0, nf]) {
            cylinder(d = plug_diameter, h = mount_depth + dpf);
            cylinder(d = outer_diameter - 2 * side_wall_strength, h = mount_depth - top_wall_strength + dpf);
        }
        
    }
}

module cap() {
    difference() {
        union() {
            cylinder(d = outer_diameter, h = top_wall_strength);
            translate([0, 0, top_wall_strength])
                cylinder(d = outer_diameter - 2 * side_wall_strength - dpf, h = top_wall_strength);
        }
        translate([0,0,grommet_wall_strength])
            cylinder(d = 2 * grommet_diameter, h = 2 * top_wall_strength - grommet_wall_strength + pf);
        translate([0, 0, nf])
            cylinder(d = grommet_diameter, h = 2 * top_wall_strength + dpf);
    }
    
}

translate([0, 0, mount_depth])
    rotate([0, 180, 0]) 
        mount();
translate([40, 0, 0]) cap();
