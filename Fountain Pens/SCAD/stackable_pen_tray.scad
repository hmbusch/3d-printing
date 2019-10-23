use <../../Various/SCAD/rounded_box.scad>;
$fn = 128;
tolerance = 0.01;
noOfPens = 4;
connectorWidthDepth = 5;
maxPenWidth = 18;
connectorCutoutHeight = 4.5;

module connectors() {
    undersizeBottom = 0.98;
    undersizeTop = 0.95;
    connectorHeight = maxPenWidth/2 + 2 * connectorCutoutHeight;
    connectorBottom = undersizeBottom * connectorWidthDepth;
    connectorTop = undersizeTop * connectorWidthDepth;
    
    
    for(i=[0:3]) {
        translate([i * 10, 0, 0])
        union() {
            box_with_round_edges_3d([connectorBottom, connectorBottom, connectorHeight / 2], 1);
            translate([(connectorBottom - connectorTop) / 2, (connectorBottom - connectorTop) / 2, connectorHeight / 2]) 
                box_with_round_edges_3d([connectorTop, connectorTop, connectorHeight/ 2], 1);
        }
    }
}

module penTray() {
    maxPenLength = 150;
    penSpacing = 0.8;
    outerWall = 1.6;
    
    boxWidth = noOfPens * maxPenWidth + 2 * outerWall + (noOfPens - 1) * penSpacing;
    
    difference()  {
        union() {
            difference() {
                // base box
                box_with_round_edges_3d([boxWidth, maxPenLength + 2 * outerWall, maxPenWidth/2 + outerWall], 2);
                // cutout for pens
                for(i=[0:noOfPens-1]) {
                    // offset by pen number
                    translate([i * (maxPenWidth + penSpacing), 0, 0])
                    translate([maxPenWidth/2 + outerWall, maxPenLength + outerWall, maxPenWidth/2 + outerWall])
                    rotate([90, 0, 0]) cylinder(d = maxPenWidth, h = maxPenLength);
                } 
            }
            for(offset = [
                [outerWall - 0.6, outerWall - 0.6, 0],
                [outerWall - 0.6, maxPenLength - 2 * outerWall - 0.6, 0],
                [boxWidth - (connectorWidthDepth + 1) - outerWall + 0.6, maxPenLength - 2 * outerWall - 0.6, 0],
                [boxWidth - (connectorWidthDepth + 1) - outerWall + 0.6, outerWall - 0.6, 0],
            ]) {
                // solid post
                translate(offset) 
                    box_with_round_edges_3d([connectorWidthDepth + 1, connectorWidthDepth + 1, maxPenWidth/2 + outerWall], 1);
            }
        }
        for(offset = [
            [outerWall - 0.6, outerWall - 0.6, 0],
            [outerWall - 0.6, maxPenLength - 2 * outerWall + 0.6, 0],
            [boxWidth - connectorWidthDepth - outerWall + 0.6, maxPenLength - 2 * outerWall + 0.6, 0],
            [boxWidth - connectorWidthDepth - outerWall + 0.6, outerWall - 0.6, 0],
        ]) {
            // upper post cutout
            translate(offset) 
            translate([0, 0, maxPenWidth/2 - connectorCutoutHeight + outerWall + tolerance])
                box_with_round_edges_3d([connectorWidthDepth + tolerance, connectorWidthDepth + tolerance, connectorCutoutHeight], 1);
            // lower post cutout
            translate(offset) 
            translate([0, 0, -tolerance]) 
                box_with_round_edges_3d([connectorWidthDepth + tolerance, connectorWidthDepth + tolerance, connectorCutoutHeight], 1);
        }
    }
}



/**
 * Renders a sample pen with a maximum reference size.
 */
module samplePen() {
    penLength = 140;
    penCapDia = 18;
    penCapLength = 65;
    penBarrelDia = 14;
    penBarrelLength = penLength - penCapLength;
    penClipWidth = 6;
    penClipHeight = 2.5;
    penClipLength = penCapLength - 10;
    
    // cap
    color("Purple") cylinder(d = penCapDia, h = penCapLength);
    // barrel
    color("Purple") translate([0, 0, penCapLength]) cylinder(d = penBarrelDia, h = penBarrelLength);
    // clip
    color("Silver") translate([penCapDia/2, -penClipWidth/2, (penCapLength - penClipLength)/2]) cube([penClipHeight, penClipWidth, penClipLength]);
}

penTray();
translate([0, -20, 0]) connectors();
