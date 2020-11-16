include <gopro-mount-library.scad>

shelf_thickness = 18;
mount_thickness = 5;
mount_width = 50;

hole_offset = (mount_width - shelf_thickness) / 2;

f = 0.01;
df = f * 2;

screw_dia = 3.2;
screw_head_dia = 6.2;
screw_head_height = 2;

difference() {
    union() {
        hull() {
            translate([-hole_offset, 0, 0])
                cylinder(d = shelf_thickness, h = mount_thickness);
            translate([hole_offset, 0, 0])
                cylinder(d = shelf_thickness, h = mount_thickness);    
        }
        translate([gopro_tripod_width/2, 0, mount_thickness])
            rotate([-90, 0, 90])
                gopro_mount_tripod_side();
    }
    translate([-hole_offset, 0, 0]) {
        translate([0, 0, -f])
            cylinder(d = screw_dia, h = mount_thickness + df);
        translate([0, 0, mount_thickness - screw_head_height])
            cylinder(d1 = screw_dia, d2 = screw_head_dia, h = screw_head_height + f);
    }
    translate([hole_offset, 0, 0]) {
        translate([0, 0, -f])
            cylinder(d = screw_dia, h = mount_thickness + df);
        translate([0, 0, mount_thickness - screw_head_height])
            cylinder(d1 = screw_dia, d2 = screw_head_dia, h = screw_head_height + f);        
    }
    
}
