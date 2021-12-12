use <../../Various/SCAD/rounded_box.scad>

$fn = 64;
fudge = 0.01;
inch = 25.4;

// POWER MODULE MEASUREMENTS
hole_spacing_x = 4 * inch;
hole_spacing_y = 2.25 * inch;
module_x = 4.25 * inch;
module_y = 2.5 * inch;
module_z = 30.5;

// SMD component height is 3.5mm
smd_component_height = 3.5;

// DESIGN MEASUREMENTS
clearance_x = 20;
clearance_y = 2;
clearance_z_pos = 5;
clearance_z_neg = smd_component_height + 1.5;

wall_thickness = 1.8;

// M3 for tapping
hole_diameter = 2.5;

// fits M3 without screwing
hole_outer_diameter = 3.1;

lid_post_diameter = 6;
lid_post_hole_z = 6;
lid_post_position_correction = 0.5;

xt60_cutout_y = 20;
xt60_cutout_z = 12;
xt60_cutout_offset_z = 5;

// ventilation slot width / spacing
slot_width = 2;

// grommet for mains power cable
grommet_outer_diameter = 15;
grommet_inner_diameter = 11.5;
grommet_wall_strength = 1;

strain_relief_x = 10;
strain_relief_y = 30;
strain_relief_offset_x = 5;

cable_diameter = 6;

screw_head_diameter = 6;
screw_head_height = 3.6;

// Derived values, do not edit
pf = fudge;
dpf = 2 * pf;
nf = -fudge;
case_outer_x = module_x + 2 * clearance_x + 2 * wall_thickness;
case_outer_y = module_y + 2 * clearance_y + 2 * wall_thickness;
case_outer_z = module_z + clearance_z_pos + clearance_z_neg + wall_thickness; 
case_inner_x = module_x + 2 * clearance_x;
case_inner_y = module_y + 2 * clearance_y;
case_inner_z = module_z + clearance_z_pos + clearance_z_neg + pf;
hole_offset_x = (module_x - hole_spacing_x) / 2;
hole_offset_y = (module_y - hole_spacing_y) / 2;

lid_mp_pos_x1 = lid_post_diameter/2 + lid_post_position_correction;
lid_mp_pos_x2 = case_outer_x - lid_post_diameter/2 - lid_post_position_correction;
lid_mp_pos_y1 = lid_post_diameter/2 + lid_post_position_correction;
lid_mp_pos_y2 = case_outer_y - lid_post_diameter/2 - lid_post_position_correction;

supply_mp_offset_x = wall_thickness + clearance_x + hole_offset_x;
supply_mp_offset_y = wall_thickness + clearance_y + hole_offset_y;

slot_offset_x = supply_mp_offset_x + 2 * hole_diameter;
slot_offset_y = supply_mp_offset_y;
number_of_slots = (hole_spacing_x - 4 * hole_diameter) / (2 * slot_width);

module power_supply() {
    cube([module_x, module_y, module_z]);
}

module mounting_post(height = clearance_z_neg, hole_height = clearance_z_neg, diameter = 2 * hole_diameter) {
    difference() {
        cylinder(d = diameter, h = height);
        translate([0, 0, height - hole_height]) 
            cylinder(d = hole_diameter, h = hole_height);
    }    
}

module case() {    
    // case body
    union() {
        difference() {
            union() {  
                difference() {
                    linear_extrude(height = case_outer_z)
                        box_with_round_edges_2d(width = case_outer_x, depth = case_outer_y);
                    translate([0, 0, wall_thickness])
                        linear_extrude(height = case_inner_z)
                            offset(-wall_thickness) 
                                box_with_round_edges_2d(width = case_outer_x, depth = case_outer_y);
                }
                
                // strain relief for strain relief ;-)
                translate([case_outer_x - wall_thickness /*- strain_relief_x */- strain_relief_offset_x, case_outer_y / 2 - strain_relief_y/2, 0]) 
                    cube([strain_relief_offset_x, strain_relief_y, (case_outer_z - grommet_outer_diameter) / 2 ]);
                // cable strain relief
                difference() {
                    translate([case_outer_x - wall_thickness - strain_relief_x - strain_relief_offset_x, case_outer_y / 2 - strain_relief_y/2, 0]) {
                        difference() {
                            box_with_round_edges_3d(dimensions = [strain_relief_x, strain_relief_y, case_outer_z/2], edges = [true, false, true, false]);
                            translate([strain_relief_x/2, strain_relief_x/2, case_outer_z/2 - lid_post_hole_z + pf])
                                cylinder(d = hole_diameter, h = lid_post_hole_z);
                            translate([strain_relief_x/2, strain_relief_y - strain_relief_x/2, case_outer_z/2 - lid_post_hole_z + pf])
                                cylinder(d = hole_diameter, h = lid_post_hole_z);
                        }
                    }
                    translate([case_outer_x - wall_thickness - strain_relief_x - strain_relief_offset_x + nf, case_outer_y/2, case_outer_z/2])
                        rotate([0, 90, 0])
                            cylinder(d = cable_diameter, h = 100);
                    
                }
             
            }
            
            // XT60 cutouts, use with https://github.com/AlbertPhan/XTConnector-PanelMount
            translate([nf, case_outer_y/2 - xt60_cutout_y/2, wall_thickness + xt60_cutout_offset_z])
                cube([wall_thickness + dpf, xt60_cutout_y, xt60_cutout_z]);
            translate([nf, case_outer_y/2 - xt60_cutout_y/2, case_outer_z - xt60_cutout_offset_z - xt60_cutout_z])
                cube([wall_thickness + dpf, xt60_cutout_y, xt60_cutout_z]);
            
            // thinner wall and hole for grommet
            translate([case_outer_x - wall_thickness + nf, case_outer_y/2, case_outer_z/2])
                rotate([0, 90, 0]) {
                    cylinder(d = grommet_outer_diameter, h = wall_thickness - grommet_wall_strength + pf);       
                    cylinder(d = grommet_inner_diameter, h = wall_thickness + dpf);
                }
                
            // bottom ventilation slots
            translate([slot_offset_x, slot_offset_y, nf])
                for (slot_no = [0:number_of_slots]) {
                    translate([slot_no * slot_width * 2, 0, 0]) {
                        hull() {
                            cylinder(d = slot_width, h = wall_thickness + dpf);
                            translate([0, module_y / 2 - slot_offset_y, 0])
                                cylinder(d = slot_width, h = wall_thickness + dpf);
                            }
                        hull() {
                            translate([0, module_y / 2, 0])
                                cylinder(d = slot_width, h = wall_thickness + dpf);
                            translate([0, module_y - slot_offset_y, 0])
                                cylinder(d = slot_width, h = wall_thickness + dpf);
                        }
                    }
                }  
          
            // holes for feet
            translate([0.08 * case_outer_x, 0.15 * case_outer_y, nf])
                cylinder(d = hole_outer_diameter, h = wall_thickness + dpf);
            translate([0.08 * case_outer_x, 0.85 * case_outer_y, nf])
                cylinder(d = hole_outer_diameter, h = wall_thickness + dpf);
            translate([0.92 * case_outer_x, 0.85 * case_outer_y, nf])
                cylinder(d = hole_outer_diameter, h = wall_thickness + dpf);
            translate([0.92 * case_outer_x, 0.15 * case_outer_y, nf]) 
                cylinder(d = hole_outer_diameter, h = wall_thickness + dpf);                
        }
                      
        // lid mounting posts
        translate([lid_mp_pos_x1, lid_mp_pos_y1, wall_thickness])
            mounting_post(height = case_inner_z, hole_height = lid_post_hole_z, diameter = lid_post_diameter);
        translate([lid_mp_pos_x1, lid_mp_pos_y2, wall_thickness])
            mounting_post(height = case_inner_z, hole_height = lid_post_hole_z, diameter = lid_post_diameter);
        translate([lid_mp_pos_x2, lid_mp_pos_y2, wall_thickness])
            mounting_post(height = case_inner_z, hole_height = lid_post_hole_z, diameter = lid_post_diameter);
        translate([lid_mp_pos_x2, lid_mp_pos_y1, wall_thickness])
            mounting_post(height = case_inner_z, hole_height = lid_post_hole_z, diameter = lid_post_diameter);
        
        // supply mounting_posts
        translate([supply_mp_offset_x, supply_mp_offset_y, wall_thickness])
            mounting_post(diameter = 6);
        translate([supply_mp_offset_x, supply_mp_offset_y + hole_spacing_y, wall_thickness])
            mounting_post(diameter = 6);
        translate([supply_mp_offset_x + hole_spacing_x, supply_mp_offset_y + hole_spacing_y, wall_thickness])
            mounting_post(diameter = 6);
        translate([supply_mp_offset_x + hole_spacing_x, supply_mp_offset_y, wall_thickness])
            mounting_post(diameter = 6);           
    }
}

module cable_clamp() {
    difference() {
        box_with_round_edges_3d(dimensions = [strain_relief_x, strain_relief_y, wall_thickness * 2]);
        translate([strain_relief_x/2, strain_relief_x/2, nf])
            cylinder(d = hole_outer_diameter, h = wall_thickness * 2 + dpf);
        translate([strain_relief_x/2, strain_relief_y - strain_relief_x/2, nf])
            cylinder(d = hole_outer_diameter, h = wall_thickness * 2 + dpf);
        translate([nf, strain_relief_y/2, cable_diameter])
            rotate([0, 90, 0])
                cylinder(d = cable_diameter, h = strain_relief_x + dpf);        
    }
}

module feet_round() {
    outer_diameter = screw_head_diameter + 2 * wall_thickness;
    for(x = [0:1]) {
        for(y = [0:1]) {
            translate([x * (outer_diameter + 2), y * (outer_diameter + 2), 0]) {
                difference() {
                    cylinder(d = outer_diameter, h = screw_head_height + wall_thickness);
                    translate([0, 0, nf])
                        cylinder(d = hole_outer_diameter, h = screw_head_height + wall_thickness + dpf);
                    translate([0, 0, wall_thickness])
                        cylinder(d = screw_head_diameter, screw_head_height + pf);
                }
            }
        }
    }
}

module feet_bar() {
    feet_x = case_outer_y/4;
    feet_z = screw_head_height + wall_thickness;
    
    for(x = [0:1]) {
        translate([x * (feet_x + 5), 0, 0])
        difference() {
            box_with_round_edges_3d(dimensions = [feet_x, case_outer_y, feet_z]);
            translate([case_outer_y/8, 0.15 * case_outer_y, nf]) {
                cylinder(d = hole_outer_diameter, h = feet_z + dpf);
                translate([0, 0, wall_thickness])
                    cylinder(d = screw_head_diameter, h = screw_head_height + dpf);
            }
            translate([case_outer_y/8, 0.85 * case_outer_y, nf]) {
                cylinder(d = hole_outer_diameter, h = feet_z + dpf);
                translate([0, 0, wall_thickness])
                    cylinder(d = screw_head_diameter, h = screw_head_height + dpf);
            }
        }
    }
}

module lid() {
    difference() {
        union() {
            
            linear_extrude(height = wall_thickness)
                box_with_round_edges_2d(width = case_outer_x, depth = case_outer_y);
            
            // inner lip
            lip_x = case_outer_x * 0.75;
            lip_y = case_outer_y * 0.6;
            translate([(case_outer_x - lip_x)/2, wall_thickness, wall_thickness])
                cube([lip_x, wall_thickness, wall_thickness * 2]);
            translate([(case_outer_x - lip_x)/2, case_outer_y - wall_thickness * 2, wall_thickness])
                cube([lip_x, wall_thickness, wall_thickness * 2]);
            translate([wall_thickness, (case_outer_y - lip_y) / 2, wall_thickness])
                cube([wall_thickness, lip_y, wall_thickness]);
            translate([case_outer_x - 2 * wall_thickness, (case_outer_y - lip_y) / 2, wall_thickness])
                cube([wall_thickness, lip_y, wall_thickness]);    
        }
    
        
        translate([lid_mp_pos_x1, lid_mp_pos_y1, 0]) 
            cylinder(d1 = screw_head_diameter, d2= hole_outer_diameter, h = wall_thickness);        
        translate([lid_mp_pos_x1, lid_mp_pos_y2, 0])
            cylinder(d1 = screw_head_diameter, d2= hole_outer_diameter, h = wall_thickness);
        translate([lid_mp_pos_x2, lid_mp_pos_y2, 0])
            cylinder(d1 = screw_head_diameter, d2= hole_outer_diameter, h = wall_thickness);
        translate([lid_mp_pos_x2, lid_mp_pos_y1, 0])
            cylinder(d1 = screw_head_diameter, d2= hole_outer_diameter, h = wall_thickness);
        
        // top ventilation slots
        translate([slot_offset_x, slot_offset_y, nf])
            for (slot_no = [0:number_of_slots]) {
                translate([slot_no * slot_width * 2, 0, 0]) {
                    hull() {
                        cylinder(d = slot_width, h = wall_thickness + dpf);
                        translate([0, module_y / 2 - slot_offset_y, 0])
                            cylinder(d = slot_width, h = wall_thickness + dpf);
                    }
                    hull() {
                        translate([0, module_y / 2, 0])
                            cylinder(d = slot_width, h = wall_thickness + dpf);
                        translate([0, module_y - slot_offset_y, 0])
                            cylinder(d = slot_width, h = wall_thickness + dpf);
                    }
                }
            }  
    }
}

module print() {
    case();
    translate([wall_thickness + clearance_x, wall_thickness + clearance_y, wall_thickness + clearance_z_neg])
        %power_supply();    
    translate([-2 * strain_relief_x, 0, 0])
        cable_clamp();
    translate([-5 * strain_relief_x, 06, 0]) 
        feet_round();
    translate([- case_outer_y * 0.75, case_outer_x/3, 0]) 
        feet_bar();
    translate([0, case_outer_y + 10, 0]) 
        lid();    
}

print();

