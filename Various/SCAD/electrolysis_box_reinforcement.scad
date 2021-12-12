use <../../Various/SCAD/rounded_box.scad>

$fn = 32;

box_ledge_width = 15;
box_overhang = 30;
holder_thickness = 8;

f = 0.01;
df = f * 2;

module screwhole() {
    rotate([0, -90, 0]) {
        cylinder(d = 3.5, h = 2 * holder_thickness);
        cylinder(d1 = 7, d2 = 3.5, h = 2);
    }
}

module holder() {
    difference() {
        // main body
        box_with_round_edges_3d([holder_thickness + box_overhang, 2 * holder_thickness + box_ledge_width, box_overhang]);
        translate([holder_thickness, holder_thickness, -f])
            cube([box_overhang + f, box_ledge_width, box_overhang + df]);
    translate([holder_thickness + f, (2 * holder_thickness + box_ledge_width)/2, box_overhang/4])
        screwhole();
    translate([holder_thickness + f, (2 * holder_thickness + box_ledge_width)/2, 3 * box_overhang/4])
        screwhole();        
    }
}

holder();


