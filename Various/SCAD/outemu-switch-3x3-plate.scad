key_x = 14;
key_y = key_x;

key_clearance_x = 25;
key_clearance_y = 25;

key_rows = 3;
key_columns = 3;

plate_thickness = 1.5;

dim_x = key_rows * key_clearance_x;
dim_y = key_columns * key_clearance_y;

f = 0.01;
df = 2 * f;

difference() {
    cube([dim_x, dim_y, plate_thickness]);
    for(x = [1 : key_rows]) {
        for(y = [1 : key_columns]) {
            translate([(x-1) * key_clearance_x + (key_clearance_x - key_x)/2, (y-1) * key_clearance_y + (key_clearance_y - key_y)/2, -f])
                cube([key_x, key_y, plate_thickness + df]);
        }
    }
}