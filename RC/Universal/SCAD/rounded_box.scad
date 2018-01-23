/**
 * Small "library" for creating boxes with rounded edges.
 *
 * Hendrik Busch, 2017 (https://github.com/hmbusch)
 *
 */
 
/**
 * Call to create a box with rounded edges (edges will be round on one plane only).
 * Be sure to increase $fn for nicer edges.
 * 
 * @param width
 *          the desired width of the box (default is 10mm)
 * @param depth
 *          the desired depth of the box (default is 10mm)
 * @param height
 *          the desired height of the box (default is 10mm)
 * @param edge_radius
 *          the radius of all the edges on the xy-plane (default is 2mm)
 *
 */
module box_with_round_edges(width = 10, depth = 10, height = 10, edge_radius = 2) {
    translate([edge_radius, edge_radius, 0]) hull() {
        ed = edge_radius * 2;
        cylinder(d = ed, h = height);
        translate([width - ed, 0, 0]) cylinder(d = edge_radius * 2, h = height);
        translate([0, depth - ed, 0]) cylinder(d = edge_radius * 2, h = height);
        translate([width - ed, depth -ed, 0]) cylinder(d = edge_radius * 2, h = height);
    }
}