/**
 * Small "library" for creating boxes with rounded edges.
 *
 * Hendrik Busch, 2017-20 (https://github.com/hmbusch)
 *
 */

/**
 * Creates either a circle with the given diameter or a square
 * where each side has the length of the diameter value. This module
 * exists to save code lines and should not be used externally.
 * 
 * @param circle
 *          if 'true', draw a circle, otherwise draw a square
 * @param diameter
 *          the measurement for the circle diameter or square side length
 */
module squareOrCircle(circle, diameter) {
    if (circle) {
        circle(d = diameter);
    } else {
        square([diameter, diameter], center = true);
    }
}

/**
 * Creates either a sphere with the given diameter or a half-sphere
 * where each side has the length of the diameter value. This module
 * exists to save code lines and should not be used externally.
 * 
 * @param sphere
 *          if 'true', draw a sphere, otherwise draw a cube
 * @param diameter
 *          the measurement for the sphere diameter or cube side length
 */
module cubeOrSphere(sphere, diameter, angle = 0) {
    if (sphere) {
        sphere(d = diameter);        
    } else {
        difference() {
            sphere(d = diameter);
            translate([diameter/4, 0, 0]) 
                cube([diameter/2, diameter, diameter], true);
        }
    }
}
 
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
 * @param edges
 *          array of four boolean values to determine which of the four
 *          corners should be round (true) and which not (false). Order is
 *          bottom left, bottom right, top left, top right. Default value
 *          is true for all corners
 */  
module box_with_round_edges_2d(width = 10, depth = 10, edge_radius = 2, edges = [true, true, true, true]) {
    if (edge_radius <= 0) {
        square([width, depth]);
    } else {
        ed = edge_radius * 2;
        translate([edge_radius, edge_radius, 0]) hull() {
            squareOrCircle(edges[0], ed);
            translate([width - ed, 0, 0]) squareOrCircle(edges[1], ed);
            translate([0, depth - ed, 0]) squareOrCircle(edges[2], ed);
            translate([width - ed, depth - ed, 0]) squareOrCircle(edges[3], ed);    
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
 * @param edges
 *          array of four boolean values to determine which of the four
 *          corners should be round (true) and which not (false). Order is
 *          bottom left, bottom right, top left, top right. Default value
 *          is true for all corners
 *
 */
module box_with_round_edges_3d(width = 10, depth = 10, height = 10, edge_radius = 2, edges = [true, true, true, true]) {
	linear_extrude(height = height) {
		box_with_round_edges_2d(width, depth, edge_radius, edges);
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
 * @param edges
 *          array of four boolean values to determine which of the four
 *          corners should be round (true) and which not (false). Order is
 *          bottom left, bottom right, top left, top right. Default value
 *          is true for all corners
 *
 */
module box_with_round_edges_3d(dimensions = [10, 10, 10], edge_radius = 2, edges = [true, true, true, true]) {
	linear_extrude(height = dimensions[2]) {
		box_with_round_edges_2d(dimensions[0], dimensions[1], edge_radius, edges);
	}
}

/**
 * Call to create a box with rounded edges (edges will be round on all planes).
 * Increased $fn gives you nicer looking edges but will also increase preview 
 * and compile time drastically (there are maaaany edges in these boxes).
 * This is still work in progress as it is rather tricky do get the box to look
 * correctly if single corners are not round. It involves working with either
 * spheres, half-spheres or cubes, depending on the look of connected corners. 
 *
 * @param dimensions
 *          3-value-array with x, y and z dimensions (default is 10x10x10mm).
 * @param edge_radius
 *          the radius of all the edges on the xy-plane (default is 2mm)
 * @param edges
 *          three-dimensional array to control each corner individually (2x2x2 elements).
 *          'true' gives you a round corner, 'false' a pointy one. Outer array is x, then y,
 *          then z.
 */
module cube_with_round_edges(dimensions = [10, 10, 10], edge_radius = 2, edges = [ [ [true, true], [true, true] ], [ [true, true], [true, true] ] ]) {
    dia = 2 * edge_radius;
    hull() {
        for(x = [0, 1]) {
            for (y = [0, 1]) {
                for (z = [0, 1]) {
                    trans_x = x == 0 ? edge_radius : dimensions[0] - edge_radius;
                    trans_y = y == 0 ? edge_radius : dimensions[1] - edge_radius;
                    trans_z = z == 0 ? edge_radius : dimensions[2] - edge_radius;
                    translate([trans_x, trans_y, trans_z])
                        cubeOrSphere(edges[x][y][z], dia);
                }
            }
        }
    }
}