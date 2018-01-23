$fn = 64;

module washer(height = 1.2) {
    difference() {
        cylinder(d = 7, h = height);
        translate([0, 0, -0.01]) cylinder(d = 3.2, h = height + 0.02);
    }
}

for (pos = [[0, 0], [0, 8], [8,0], [8,8]]) {
    translate([pos[0], pos[1], 0]) washer();
}

translate([0, -20, 0])
for (pos = [[0, 0], [0, 8], [8,0], [8,8]]) {
    translate([pos[0], pos[1], 0]) washer(1.4);
}
