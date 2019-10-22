plate_height = 1;
screw_hole = 3.2;
hole_spacing = 30.5;
bec_length = 15 + 4;
bec_height = 8.5;
bec_thickness = 3;
wall_thickness = 1.2;
strut_width = 6;

$fn = 64;

difference() {
    union() {
        hull() {
            translate([-hole_spacing/2, 0, 0]) cylinder(d = 6, h = plate_height);
            translate([-hole_spacing/2 + 2, 2, 0]) cube([3, strut_width, plate_height]);
        }
        hull() {
            translate([hole_spacing/2, 0, 0]) cylinder(d = 6, h = plate_height);
            translate([hole_spacing/2 - 5, 2, 0]) cube([3, strut_width, plate_height]);
        }
        translate([-12.5, 2, 0]) cube([25, strut_width, plate_height]);
        
        // bec mount
        edge_offset = (6 - bec_thickness - 2 * wall_thickness) / 2;
        translate([-bec_length/2, 2 + edge_offset, plate_height]) cube([bec_length, 1.2, bec_height * 1.1]);
        translate([-bec_length/2, 2+ edge_offset + wall_thickness + bec_thickness, plate_height]) cube([bec_length, 1.2, bec_height * 1.1]);
    
    }
    
    // screw holes
    translate([-hole_spacing/2, 0, -0.1]) cylinder(d = screw_hole, h = plate_height + 0.2);
    translate([hole_spacing/2, 0, -0.1]) cylinder(d = screw_hole, h = plate_height + 0.2);
    
    // weight reduction / air vents
    translate([bec_length / 2 - 5, 3 + strut_width, bec_height / 2 + plate_height]) rotate([90, 0, 0]) cylinder(d = 7, h = 8);    
    translate([-bec_length / 2 + 5, 3 + strut_width, bec_height / 2 + plate_height]) rotate([90, 0, 0]) cylinder(d = 7, h = 8);    
}