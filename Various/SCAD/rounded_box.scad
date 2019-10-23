/**
 * Small "library" for creating boxes with rounded edges.
 *
 * Hendrik Busch, 2017-19 (https://github.com/hmbusch)
 *
 */
 
/**
 * Creates a 2D-shape of a box with the given dimensions and rounded edges. 
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
 */  
module box_with_round_edges_2d(width = 10, depth = 10, edge_radius = 2) {
    if (edge_radius <= 0) {
        square([width, depth]);
    } else {
        ed = edge_radius * 2;
        translate([edge_radius, edge_radius, 0]) hull() {
            circle(d = ed);
            translate([width - ed, 0, 0]) circle(d = ed);
            translate([0, depth - ed, 0]) circle(d = ed);
            translate([width - ed, depth - ed, 0]) circle(d = ed);    
        }
    }
}
 
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
module box_with_round_edges_3d(width = 10, depth = 10, height = 10, edge_radius = 2) {
	linear_extrude(height = height) {
		box_with_round_edges_2d(width, depth, edge_radius);
	}
}

/**
 * Call to create a box with rounded edges (edges will be round on one plane only).
 * Be sure to increase $fn for nicer edges. This module has inputs that resemble
 * those of cube() so that it can act as a drop-in replacement.
 * 
 * @param dimensions
 *          3-value-array with x, y and z dimensions (default is 10x10x10mm).
 * @param edge_radius
 *          the radius of all the edges on the xy-plane (default is 2mm)
 *
 */
module box_with_round_edges_3d(dimensions = [10, 10, 10], edge_radius = 2) {
	linear_extrude(height = dimensions[2]) {
		box_with_round_edges_2d(dimensions[0], dimensions[1], edge_radius);
	}
}