/**
 * This is a divider for Alexandre Chappel's 1x1 organizer box.
 * It is intended to be combined with the model for the box (e.g.
 * via 3DBuilder), the divided box can then be split into two 
 * 0.5x1 boxes.
 */
difference() {
    cube([52, 74, 2]);
        linear_extrude(2) {
            polygon([[0, 0], [4, 0], [0, 4]]);
            polygon([[52, 0], [52, 4], [48, 0]]);
        }
}