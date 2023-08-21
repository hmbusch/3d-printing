use <../../Various/SCAD/rounded_box.scad>;

$fn = 64;

/**
 * RISING STAND FOR 30ML DIAMINE INK BOTTLES
 *
 * This design is intended to display Diamine 30ml plastic
 * ink bottles on a single shelf compartment (IKEA Bonde in
 * my case) with room left for other items.
 * Each of the bottles measures roughly 27x27x71.5mm, with 
 * the slight problem that the name of the ink color is printed
 * close to the bottom of each bottle. So stacking them in an
 * overlapping fashion looks nice and conserves some space, but
 * make searching for a particular ink color a tedious task
 * (which admittedly could be overcome by sorting them alpha-
 * betically or so, but that is not the point).
 * The shelf compartment I intended the stand for measures 
 * 33.5x33.5cm in width and height and 38cm in depth.
 *
 */
 
bottleWidth = 27;
bottleDepth = 27;
bottleHeight = 71.5;
 
/**
 * The amount of height overlap between one row and the one 
 * behind it. With the modern labels 5-7mm are ok, any larger
 * overlap will block the color labels from being readable.
 */
bottleOverlap = 6;
 
/**
 * The space between each bottle and between the bottles and 
 * the outer edge. Should be set in multiples of you extrusion
 * width for easier printing.
 */
bottleSpacing = 1.2;

/**
 * The amount of additional space given to the bottle cutouts
 * so that the fit is not super tight.
 */
bottleTolerance = 0.1;

/**
 * The amount of additional cutout dimension to ensure the prerender
 * view looks nice.
 */
fudge = 0.01;

/**
 * The number of bottles per row.
 */
bottlesInRow = 7;

// These are the values used in the design, derived from the setup 
// values above. Don't change those if you don't know what you are 
// doing.
finalBottleWidth = bottleWidth + bottleTolerance;
finalBottleDepth = bottleDepth + bottleTolerance;
rowWidth = bottlesInRow * (finalBottleWidth + bottleSpacing) + bottleSpacing;
rowDepth = finalBottleDepth + 2 * bottleSpacing;
//heightUnit = bottleHeight - bottleOverlap;
heightUnit = 30;
                 
 /**
  * Creates a stand with a single row, using the giving parameters.
  *
  * @param heightOffset 
  *        The amount by which to raise the stand of the ground. This
  *        height is additional to the stands own height and bottom 
  *        thickness below the bottles (which is 1mm). Default value
  *        is 0.
  * @param bottlesInRow
  *        The stand will allow for this many bottles to be placed on
  *        it. Default value is 6.
  */
module singleRowStand(heightOffset = 0, bottlesInRow = 6, cornerRadius = 0, edges = [true, true, true, true], offsetBottles = false) {
    if (heightOffset > 0) {
        box_with_round_edges_3d([rowWidth, rowDepth, heightOffset * heightUnit], cornerRadius, edges);
    }
    translate([0, 0, heightOffset * heightUnit]) {
        difference() {
            box_with_round_edges_3d([rowWidth, rowDepth, bottleOverlap + 1], cornerRadius, edges);
            if (offsetBottles) {
                for (i = [0 : bottlesInRow - 2]) {
                    widthOffset = (finalBottleWidth + bottleSpacing) / 2;
                    translate([widthOffset + bottleSpacing + i * (finalBottleWidth + bottleSpacing), bottleSpacing, 1]) {
                        box_with_round_edges_3d([finalBottleWidth, finalBottleDepth, bottleOverlap + fudge], 3.5);
                    }
                } 
            } else {
                for (i = [0 : bottlesInRow - 1]) {                   
                    translate([bottleSpacing + i * (finalBottleWidth + bottleSpacing), bottleSpacing, 1]) {
                        box_with_round_edges_3d([finalBottleWidth, finalBottleDepth, bottleOverlap + fudge], 3.5);
                    }
                }
            }
        }
    }
}

for (row = [0 : 4]) {
    translate([0, row * rowDepth + (row * 10), 0]) {
        if (row % 2 == 1) {
            singleRowStand(row, bottlesInRow, 4, edges = [true, true, true, true], offsetBottles = true);
        } else {
            singleRowStand(row, bottlesInRow, 4, edges = [true, true, true, true], offsetBottles = false);
        }
    }
}


