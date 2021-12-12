use <../../Various/SCAD/rounded_box.scad>;

$fn = 32;

/*
 * Provides a guide for aligning 15mm boards with a 10cm spacing.
 * Drawing a line along this guide draws a perfect middle line.
 *
 *         <- 10cm ->Next board  
 *  |     |          |  |  |
 *  |     |==========+==|  |
 *  |     |==========+==|  | 
 *  |     |          |  |  |
 *  Board    Tool      Line
 * <-15mm-><-- 10.75cm ->  
 *
 */
difference() {
    cube([107.5, 100, 10]);
    translate([3, 3, 3])
        box_with_round_edges_3d([101.5, 94, 25], 5);
    translate([5, 5, 0])
        box_with_round_edges_3d([97.5, 90, 30], 5);    
}

