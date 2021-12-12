spacer_x = 20;
spacer_y = 15;
spacer_z = 3;

for(x = [0:3]) {
    for(y = [0:4]) {
        translate([x * spacer_x * 1.1, y * spacer_y * 1.2, 0])
            cube([spacer_x, spacer_y, spacer_z]);
    }
}