include <../../Various/SCAD/screw_holes.scad>;

tray_x = 145.8;
tray_y = 85;
tray_pcb_z = 1.35;

standoff_height = 24.4;
standoff_large_height = 44.6;
standoff_diameter = 5;
standoff_hole = 3.1;

standoff_spacing_x = 135;
standoff_spacing_y = 71;

battery_holder_y_offset = 3.5;

battery_holder_solder_point_x_offset = 23.3;
battery_holder_solder_point_width = 6.8;
battery_holder_solder_point_spacing = 12.6;
battery_holder_solder_point_center_spacing = 15.2;

side_slot_slack = 0.5;
side_slot_mount_wall_thickness = 2;
slot_mount_x = tray_x + 2 * side_slot_mount_wall_thickness + side_slot_slack;    
slot_mount_y = tray_pcb_z + 2 * side_slot_mount_wall_thickness + side_slot_slack;


f = 0.01;
df = 2 * f;

$fn = 64;

// derived values

module batteryTraySingle() {
    
    
    union() {
        standoff_offset_x = (tray_x - standoff_spacing_x)/2 - 0.5;
        standoff_offset_y = (tray_y - standoff_spacing_y)/2;
        
        // pcb with mounting holes
        difference() {
            // pcb
            color("LimeGreen")
                cube([tray_x, tray_y, tray_pcb_z]);

            // standoff holes
            for(pos_x = [standoff_offset_x, standoff_offset_x + standoff_spacing_x]) {
                for (pos_y = [standoff_offset_y, standoff_offset_y + standoff_spacing_y]) {
                    translate([pos_x, pos_y, -f])
                        cylinder(d = standoff_hole, h = tray_pcb_z + df);
                }
            }
        }
        
        // standoffs        
        for(pos_x = [standoff_offset_x, standoff_offset_x + standoff_spacing_x]) {
            for (pos_y = [standoff_offset_y, standoff_offset_y + standoff_spacing_y]) {
                translate([pos_x, pos_y, tray_pcb_z])
                    color("Goldenrod")
                    difference() {
                        cylinder(d = standoff_diameter, h = standoff_height, $fn = 6);
                        translate([0, 0, -f])
                            cylinder(d = standoff_hole, h = standoff_height + df);
                    }
            }
        }
        
        // battery holder
        battery_holder_x = 121;
        battery_holder_y = 78;
        battery_holder_z = 22;
        battery_holder_x_offset = 16;        
        battery_holder_wall = 1.5;
        
        color("DimGray")
        difference() {
            translate([battery_holder_x_offset, battery_holder_y_offset, tray_pcb_z])
                cube([battery_holder_x, battery_holder_y, battery_holder_z]);
            translate([battery_holder_x_offset + battery_holder_wall, 
                       battery_holder_y_offset + battery_holder_wall, 
                       tray_pcb_z + battery_holder_wall])
                cube([battery_holder_x - 2 * battery_holder_wall, 
                      battery_holder_y - 2 * battery_holder_wall, 
                      battery_holder_z - battery_holder_wall + f]);
        }
        
        // batteries
        battery_x_spacing = (battery_holder_x - 2 * battery_holder_wall - 6 * 18) / 7;
        battery_y_offset = battery_holder_y_offset + (battery_holder_y - 65)/2;
        
        color("PaleGreen")
        for(i = [0 : 1 : 5]) {
            battery_x_offset = battery_holder_x_offset + 18/2 + battery_holder_wall + (i+1) * battery_x_spacing + i * 18;
            translate([battery_x_offset, battery_y_offset, tray_pcb_z + battery_holder_wall + 18/2])
                rotate([-90, 0, 0])
                    cylinder(d=18, h = 65);
        }
        
        // screw terminals
        screw_terminal_x = 10.5;
        screw_terminal_y = 20;
        screw_terminal_z = 15;
        
        screw_terminal_x_offset = tray_x + 3 - screw_terminal_x;
        screw_terminal_y_offset = 25.5;
        screw_terminal_y_spacing = 5;
        
        color("MediumSpringGreen") {
            translate([screw_terminal_x_offset, screw_terminal_y_offset, tray_pcb_z])
                cube([screw_terminal_x, screw_terminal_y, screw_terminal_z]);
            translate([screw_terminal_x_offset, 
                       screw_terminal_y_offset + screw_terminal_y + screw_terminal_y_spacing, 
                       tray_pcb_z])
                cube([screw_terminal_x, screw_terminal_y, screw_terminal_z]);
        }
        
        // XT 60 connector
        xt60_x= 8.1;
        xt60_y = 15.8;
        xt60_z = 16.8;
        
        xt60_x_offset = 8.5;
        xt60_y_offset = tray_y - 8.5 - xt60_y;
        
        color("Gold")
        translate([xt60_x_offset, xt60_y_offset, tray_pcb_z])
            cube([xt60_x, xt60_y, xt60_z]);
        
        // barrel connector
        barrel_x = 14;
        barrel_y = 10;
        barrel_z = 11;
        
        color("DimGray")
            translate([0.8, 13.7, tray_pcb_z])
                cube([barrel_x, barrel_y, barrel_z]);
        
        // balance connector
        balance_x = 8.8;
        balance_y = 25.4;
        balance_z = 8.65;
        balance_leads_x = 4.5;
        balance_leads_y = 15.8;
        balance_leads_z = 7;
        
        color("DimGray")
            translate([-2, 34, tray_pcb_z])
                cube([balance_x, balance_y, balance_z]);
           
        color("Gainsboro")
            translate([-2 + balance_x, 34 + (balance_y - balance_leads_y)/2, tray_pcb_z])
                cube([balance_leads_x, balance_leads_y, balance_leads_z]);    
    }
}

module singleSideSlotMount() {    
        
    slot_mount_z = side_slot_mount_wall_thickness + battery_holder_y_offset;

    difference() {
        cube([slot_mount_x, slot_mount_y, slot_mount_z]);
        translate([side_slot_mount_wall_thickness, side_slot_mount_wall_thickness, side_slot_mount_wall_thickness])
            cube([tray_x + side_slot_slack, tray_pcb_z + side_slot_slack, battery_holder_y_offset + f]);
        
        // We need some cutouts for the solder points of the individual battery cell
        // holders, otherwise the modules will not fit properly.
        
        solder_point_1_x = side_slot_mount_wall_thickness + side_slot_slack/2 + battery_holder_solder_point_x_offset;
        solder_point_2_x = side_slot_mount_wall_thickness + side_slot_slack/2 + battery_holder_solder_point_x_offset + 
                                battery_holder_solder_point_width + 
                                battery_holder_solder_point_spacing;
        solder_point_3_x = side_slot_mount_wall_thickness + side_slot_slack/2 + battery_holder_solder_point_x_offset + 
                                2 * battery_holder_solder_point_width + 
                                2 * battery_holder_solder_point_spacing;
        solder_point_4_x = side_slot_mount_wall_thickness + side_slot_slack/2 + battery_holder_solder_point_x_offset +
                                3 * battery_holder_solder_point_width + 
                                2 * battery_holder_solder_point_spacing + 
                                battery_holder_solder_point_center_spacing;
        solder_point_5_x = side_slot_mount_wall_thickness + side_slot_slack/2 + battery_holder_solder_point_x_offset + 
                                4 * battery_holder_solder_point_width + 
                                3 * battery_holder_solder_point_spacing + 
                                battery_holder_solder_point_center_spacing;
        solder_point_6_x = side_slot_mount_wall_thickness + side_slot_slack/2 + battery_holder_solder_point_x_offset +
                                5 * battery_holder_solder_point_width + 
                                4 * battery_holder_solder_point_spacing + 
                                battery_holder_solder_point_center_spacing;
                                
        translate([solder_point_1_x, -slot_mount_y / 2, side_slot_mount_wall_thickness])
            cube([battery_holder_solder_point_width, 2 * slot_mount_y, battery_holder_y_offset + f]);
        translate([solder_point_2_x, -slot_mount_y / 2, side_slot_mount_wall_thickness])
            cube([battery_holder_solder_point_width, 2 * slot_mount_y, battery_holder_y_offset + f]);
        translate([solder_point_3_x, -slot_mount_y / 2, side_slot_mount_wall_thickness])
            cube([battery_holder_solder_point_width, 2 * slot_mount_y, battery_holder_y_offset + f]);
        translate([solder_point_4_x, -slot_mount_y / 2, side_slot_mount_wall_thickness])
            cube([battery_holder_solder_point_width, 2 * slot_mount_y, battery_holder_y_offset + f]);
        translate([solder_point_5_x, -slot_mount_y / 2, side_slot_mount_wall_thickness])
            cube([battery_holder_solder_point_width, 2 * slot_mount_y, battery_holder_y_offset + f]);
        translate([solder_point_6_x, -slot_mount_y / 2, side_slot_mount_wall_thickness])
            cube([battery_holder_solder_point_width, 2 * slot_mount_y, battery_holder_y_offset + f]);
    }
}

module mirroredSingleSideSlotMount() {
    translate([slot_mount_x, 0, 0])
        mirror([1, 0, 0])
            singleSideSlotMount();
}

/**
 * Generates an inlay for the "Universal-Maschinenkoffer" (universal power tool box) from Hornbach,
 * a German home & garden supply store. It is intended to be used with a battery setup of 4x 6S2P
 * modules and 2x 6S1P modules, with a configuration of 1-2-2-2-2-1.
 * 
 * Link: https://www.hornbach.de/shop/Universal-Maschinenkoffer-335x235x110-mm/3882855/artikel.html
 * 
 * Need to be printed in multiple parts due to size constraints.
 */
module inlayUniversalBox10p() {
    
    // box inner measurements
    box_x = 230;
    box_y = 330;
    box_z = 106;
    
    slot_x_offset = 4;
    first_slot_y_offset = 8;
    
    inner_spacing = standoff_height + side_slot_mount_wall_thickness;
    inner_spacing_large = standoff_large_height + side_slot_mount_wall_thickness;
    
    strut_height = (box_z - tray_y - side_slot_mount_wall_thickness)/2;
    strut_width_sides = 14;
    strut_width_inner = slot_mount_y;
    
    side_panel_width = box_x - slot_mount_x - slot_x_offset;
    
    battery_protect_hole_spacing = 142;
    battery_protect_hole_dia = 6.2;
    battery_protect_nut_width = 10.1;
    battery_protect_nut_height = 6; // nut height is 4mm + 2mm additional raise in z
    battery_protect_strut_width = 20;
    battery_protect_x = 42;
    battery_protect_x_offset = 10;
    battery_protect_fuse_block_spacing = 40;
    
    fuse_block_hole_spacing_x = 41;
    fuse_block_hole_spacing_y = 15.2;
    fuse_block_hole_dia = 4.2;
    fuse_block_nut_width = 8.1;
    fuse_block_nut_height = strut_height - 4;
    fuse_block_strut_width = strut_width_sides;
    fuse_block_y_offset = 50;
  
    // nut_trap(pipe_clamp_screw_diameter, pipe_clamp_nut_width, 0, pipe_clamp_nut_height);
    
    difference() {
        union() {
            // side base struts    
            cube([strut_width_sides, box_y, strut_height]);
            translate([box_x - strut_width_sides, 0, 0])
                cube([strut_width_sides, box_y, strut_height]);
            translate([side_panel_width - strut_width_sides, 0, 0])
                cube([strut_width_sides, box_y, strut_height]);
            
            // inner base struts
            translate([side_panel_width, first_slot_y_offset, 0])
                cube([box_x - side_panel_width, strut_width_inner, strut_height]);
            translate([side_panel_width, first_slot_y_offset + inner_spacing_large, 0])
                cube([box_x - side_panel_width, strut_width_inner, strut_height]);
            translate([side_panel_width, first_slot_y_offset + 2 * inner_spacing_large, 0])
                cube([box_x - side_panel_width, strut_width_inner, strut_height]);
            translate([side_panel_width, first_slot_y_offset + 3 * inner_spacing_large, 0])
                cube([box_x - side_panel_width, strut_width_inner, strut_height]);
            translate([side_panel_width, first_slot_y_offset + 4 * inner_spacing_large, 0])
                cube([box_x - side_panel_width, strut_width_inner, strut_height]);
            translate([side_panel_width, first_slot_y_offset + inner_spacing + 4 * inner_spacing_large, 0])
                cube([box_x - side_panel_width, strut_width_inner, strut_height]);
            
            // support strut on the far end
            translate([side_panel_width, box_y - strut_width_inner - first_slot_y_offset, 0])
                cube([box_x - side_panel_width, strut_width_inner, strut_height]);

                
            // main fuse holder struts
            translate([0, box_y - fuse_block_y_offset - fuse_block_strut_width/2, 0])
                cube([side_panel_width, fuse_block_strut_width, strut_height]);
            translate([0, box_y - fuse_block_y_offset - fuse_block_strut_width/2 - fuse_block_hole_spacing_x, 0])
                cube([side_panel_width, fuse_block_strut_width, strut_height]);                
                
            // battery protect struts
            translate([0, box_y - fuse_block_y_offset - fuse_block_strut_width/2 - fuse_block_hole_spacing_x - battery_protect_fuse_block_spacing, 0])
                cube([side_panel_width, battery_protect_strut_width, strut_height]);
                
            translate([0, box_y - fuse_block_y_offset - fuse_block_strut_width/2 - fuse_block_hole_spacing_x - battery_protect_fuse_block_spacing - battery_protect_hole_spacing, 0])
                cube([side_panel_width, battery_protect_strut_width, strut_height]);
                
                
            // slots
            translate([box_x - slot_mount_x - slot_x_offset, first_slot_y_offset, strut_height])
                singleSideSlotMount();
            translate([box_x - slot_mount_x - slot_x_offset, first_slot_y_offset + inner_spacing_large, strut_height])
                singleSideSlotMount();
            translate([box_x - slot_mount_x - slot_x_offset, first_slot_y_offset + 2 * inner_spacing_large, strut_height])
                singleSideSlotMount();
            translate([box_x - slot_mount_x - slot_x_offset, first_slot_y_offset + 3 * inner_spacing_large, strut_height])
                singleSideSlotMount();
            translate([box_x - slot_mount_x - slot_x_offset, first_slot_y_offset + 4 * inner_spacing_large, strut_height])
                singleSideSlotMount();
            translate([box_x - slot_mount_x - slot_x_offset, first_slot_y_offset + inner_spacing + 4 * inner_spacing_large, strut_height])
                singleSideSlotMount();
        }
        
        // nut traps for fuse block
        translate([side_panel_width/2 + fuse_block_hole_spacing_y/2, box_y - fuse_block_y_offset, fuse_block_nut_height + 10])
            rotate([0, 180, 0])
                nut_trap(fuse_block_hole_dia, fuse_block_nut_width, 10, fuse_block_nut_height);
        translate([side_panel_width/2 - fuse_block_hole_spacing_y/2, box_y - fuse_block_y_offset - fuse_block_hole_spacing_x, fuse_block_nut_height + 10])
            rotate([0, 180, 0])
                nut_trap(fuse_block_hole_dia, fuse_block_nut_width, 10, fuse_block_nut_height);
        
        
        
        // nut traps for battery protect
        translate([side_panel_width/2, box_y - fuse_block_y_offset - fuse_block_strut_width/2 - fuse_block_hole_spacing_x - battery_protect_fuse_block_spacing + battery_protect_strut_width/2, 10 + battery_protect_nut_height])
            rotate([0, 180, 0])
                nut_trap(battery_protect_hole_dia, battery_protect_nut_width, 10, battery_protect_nut_height);
        translate([side_panel_width/2, box_y - fuse_block_y_offset - fuse_block_strut_width/2 - fuse_block_hole_spacing_x - battery_protect_fuse_block_spacing + battery_protect_strut_width/2 - battery_protect_hole_spacing, 10 + battery_protect_nut_height])
            rotate([0, 180, 0])
                nut_trap(battery_protect_hole_dia, battery_protect_nut_width, 10, battery_protect_nut_height);
        
        
    }
            
        
        
        
    
}

inlayUniversalBox10p();
