xt60_width = 8.2;
xt60_length = 16;
xt60_height = 16;

xt90_width = 11;
xt90_length = 21.2;
xt90_height = 21.5;

socket_depth = 6;
socket_lip = 1;
socket_spacing = 3;
socket_count = 5;

block_x = socket_count * (xt60_width + socket_spacing) + socket_spacing;
block_y = xt90_length + socket_spacing*2;
block_z = socket_lip + socket_depth;

sideblock_y = block_y;
sideblock_x = xt90_width + socket_spacing*2;
sideblock_z = socket_depth + socket_lip + xt90_length/2;

wall_thickness = 1.6;
fit = 0.1;

f = 0.01;
df = f*2;

module xt60() {
    translate([0, socket_lip, -f])
        cube([xt60_width, xt60_length - socket_lip*2, socket_lip + f]);
    translate([0, 0, socket_lip - f])
        cube([xt60_width, xt60_length, xt60_height]);
}

module xt60_block() {
    difference() {
        cube([block_x, block_y, block_z]);
        for(x = [1 : socket_count]) {
            translate([x * socket_spacing + (x-1) * xt60_width, socket_spacing + (xt90_length - xt60_length)/2, 0])
                xt60();
        }
    }
    difference() {
        neg_z = sideblock_x - block_z;
        translate([0, 0, -neg_z])
            cube([block_x, block_y, neg_z]);
        translate([0, wall_thickness*1.5, -neg_z])
            cube([block_x - wall_thickness, block_y - wall_thickness*3, neg_z]);

    }
}

module xt90_block() {
    difference() {
        cube([sideblock_x, sideblock_y, sideblock_z]);
        translate([socket_spacing, socket_spacing + socket_lip*2, -f])
            cube([xt90_width, xt90_length - socket_lip*4, sideblock_z + df]);
        translate([socket_spacing, socket_spacing, sideblock_z - socket_depth])
            cube([xt90_width, xt90_length, xt90_height]);
    }
}

difference() {
    translate([sideblock_z, 0, sideblock_x - block_z])
        union() {
            xt60_block();
            translate([0, 0, block_z-sideblock_x])
                rotate([0, -90, 0])
                    xt90_block();
        }
    translate([0, wall_thickness, -f])
        cube([sideblock_z + block_x - wall_thickness, block_y - wall_thickness*2, socket_spacing + f]);
}

translate([0, block_y + 10, 0])
    cube([sideblock_z + block_x - wall_thickness - fit, block_y - wall_thickness*2 - fit, socket_spacing + f]);