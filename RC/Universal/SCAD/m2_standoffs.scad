$fn = 64;

module washer(height = 1.2, m3adapter = false) {
    rotate([180, 0, 0]) difference() {
        union() {
            cylinder(d = 4.2, h = height);
            if (m3adapter) {
                translate([0, 0, -2]) cylinder(d = 3.0, h = 2);
            }
        }
        translate([0, 0, -2.01]) cylinder(d = 2.1, h = height + 2.02);
    }
}

for (pos = [[0, 0], [0, 8], [8,0], [8,8]]) {
    translate([pos[0], pos[1], 3]) washer(3, true);
}
