module_width = 18;
module_length = 28.2;
module_height = 3.1;
module_pcb_thickness = 1.5;

module_count = 8;
module_spacing = 2;

mounting_screw_dia = 3.2;
mounting_screw_head_dia = 7;
mounting_screw_head_height = 3.2;

mount_height = 5;
mount_width = 9;
mount_length = module_length + module_spacing*2;

mount_shoulder = 2;
mount_brace_width = 8;
mount_brace_length = module_count * (module_width + module_spacing) + mount_width * 3 + 0.4;
mount_brace_thickness = 3;

f = 0.01;
df = f*2;

$fn = 64;

module center_mount() {
    translate([0, 0, mount_height/2]) 
        difference() {
            cube([mount_width, mount_length, mount_height], center = true);
            translate([0, mount_brace_width/2, - mount_height/2 - f])
                cylinder(d = mounting_screw_dia, h = mount_height + df);
            translate([0, -mount_length/3, - mount_height/2 - f]) 
                cylinder(d = mounting_screw_dia, h = mount_height + df);
            translate([0, -mount_length/3, mount_height/2 - mounting_screw_head_height]) 
                cylinder(d1 = mounting_screw_dia, d2 = mounting_screw_head_dia, h = mounting_screw_head_height + f);
            translate([0, mount_length/3, - mount_height/2 - f])
                cylinder(d = mounting_screw_dia, h = mount_height + df);
            translate([0, mount_length/3, mount_height/2 - mounting_screw_head_height]) 
                cylinder(d1 = mounting_screw_dia, d2 = mounting_screw_head_dia, h = mounting_screw_head_height + f);
        }
}

module module_slot() {
    difference() {
        cube([module_width + module_spacing, mount_length, mount_height]);
        translate([module_spacing, (mount_length - module_length)/2, mount_height - module_pcb_thickness])
            cube([module_width + f, module_length, module_height + f]);
        translate([module_spacing + mount_shoulder, (mount_length - module_length)/2 + mount_shoulder, -f])
            cube([module_width - mount_shoulder*2, module_length - mount_shoulder*2, mount_height + f]);
        
    }
}

module module_holder_bottom() {
    center_mount();
    for(x = [1 : module_count/2 ]) {
        translate([mount_width/2 + x * (module_width + module_spacing), mount_length/2, 0])
            rotate([0, 0, 180])
                module_slot();
        echo(x);
        translate([-mount_width/2 - x * (module_width + module_spacing), -mount_length/2, 0])
            module_slot();
    }
}



module module_holder_brace() {
    difference() {
        union() {
            cube([mount_brace_length, mount_brace_width, mount_brace_thickness]);
            translate([0, 0, mount_brace_thickness])
                cube([mount_width, mount_brace_width, mount_height - module_pcb_thickness + module_height]);
            translate([mount_brace_length - mount_width, 0, mount_brace_thickness])
                cube([mount_width, mount_brace_width, mount_height - module_pcb_thickness + module_height]);
            translate([mount_brace_length/2 - mount_width/2 + module_spacing/2, 0, mount_brace_thickness])
                cube([mount_width - module_spacing, mount_brace_width,  module_height - module_pcb_thickness]);
        }
        translate([mount_width/2, mount_brace_width/2, -f]) {
            cylinder(d = mounting_screw_dia, h = mount_brace_thickness + mount_height - module_pcb_thickness + module_height + df);
            cylinder(d2 = mounting_screw_dia, d1 = mounting_screw_head_dia, h = mounting_screw_head_height + f);
        }
        translate([mount_brace_length - mount_width/2, mount_brace_width/2, -f]) {
            cylinder(d = mounting_screw_dia, h = mount_brace_thickness + mount_height - module_pcb_thickness + module_height + df);    
            cylinder(d2 = mounting_screw_dia, d1 = mounting_screw_head_dia, h = mounting_screw_head_height + f);
        }
        translate([mount_brace_length/2, mount_brace_width/2, -f]) {
            cylinder(d = mounting_screw_dia, h = mount_brace_thickness + mount_height - module_pcb_thickness + module_height + df);    
            cylinder(d2 = mounting_screw_dia, d1 = mounting_screw_head_dia, h = mounting_screw_head_height + f);
        }
    }
    
}

module view_assembled() {
    module_holder_bottom();
    translate([mount_brace_length/2, 0, mount_brace_thickness + mount_height - module_pcb_thickness + module_height])
        rotate([0, 180, ])    
            module_holder_brace();
}

module view_parts() {
    module_holder_bottom();
    translate([-mount_brace_length/2, mount_length, 0])
        module_holder_brace();
}

view_parts();