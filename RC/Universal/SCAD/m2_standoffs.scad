$fn = 64;

module washer(height = 1.2) {
    difference() {
        cylinder(d = 4.2, h = height);
        translate([0, 0, -0.01]) cylinder(d = 2.1, h = height + 0.02);
    }
}

for (pos = [[0, 0], [0, 8], [8,0], [8,8]]) {
    translate([pos[0], pos[1], 0]) washer(2);
}
