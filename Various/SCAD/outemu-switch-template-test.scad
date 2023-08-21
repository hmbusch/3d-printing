frame_x = 25;
frame_y = 25;
key_x = 14;
key_y = 14;
key_z_min = 0.3;
f = 0.01;
df = 2 * f;

module key_frame(height) {
    difference() {
        cube([frame_x, frame_y, height]);
        translate([(frame_x - key_x)/2, (frame_y - key_y)/2, -f])
            cube([key_x, key_y, height + df]);
    }
    translate([1, 1, height])
        linear_extrude(height = 0.2)
            text(text = str(height), size = 3);
}

for(i = [1 : 7]) {
    translate([(i - 1) * (frame_x + 5), 0, 0])
        key_frame(key_z_min + i * 0.2);
}