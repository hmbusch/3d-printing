$fn = 64;

delta_size = 16.2;
overlap = 1.5;
edge_radius = 2;
edge_dia = 2 * edge_radius;
cable_channel_dia = 10;
cable_channel_radius = 13;

size_x = delta_size + overlap;
size_y = delta_size + 2 * overlap;
size_z = delta_size + 2 * overlap;

module half_sphere(diameter) {
    difference() {
        sphere(d = diameter);
        translate([diameter/4, 0, 0]) 
            cube([diameter/2, diameter, diameter], true);
    }
}

module corner_block() {
    hull() {
        // lower corners
        translate([edge_radius, edge_radius, 0])
            rotate([0, 90, 0]) 
                half_sphere(edge_dia);
        translate([size_x - edge_radius, edge_radius, edge_radius])
            cube(edge_dia, center = true);
        translate([edge_radius, size_y - edge_radius, edge_radius])
            cube(edge_dia, center = true);
        translate([size_x - edge_dia, size_y - edge_dia, 0])
            cube([edge_dia, edge_dia, size_z]);
        
        // upper corners
        translate([edge_radius, edge_radius, size_z - edge_radius])
            sphere(d = edge_dia);
        translate([size_x, edge_radius, size_z - edge_radius])
            half_sphere(edge_dia);
        translate([edge_radius, size_y - edge_radius, size_z - edge_radius]) {
            half_sphere(edge_dia);
            translate([0, edge_dia/2, 0])
                rotate([0, 0, 90])
                    half_sphere(edge_dia);
        }
    }
}

module corner() {
    difference() {
        corner_block();
        translate([overlap, size_y - overlap, 0])
            cube([delta_size + overlap, overlap, delta_size + overlap]);
        translate([overlap, overlap, 0])
            cube([delta_size + overlap, delta_size, overlap]);
        translate([overlap, overlap, overlap])
            cube([delta_size - overlap, delta_size, delta_size]);
    }
}

corner();
