/**
 * Hole spacing within the 1HU, by definition 15.88mm or 0.625".
 */
hu_hole_spacing = 15.88;

/**
 * Height of 1 HU, by definition 44.45mm or 1.75".
 */
hu_height = 44.45;

/**
 * Width of the rail. Standard rails are 15.88mm od 0.625" in width,
 * but wider rails can be specified. Screw cutouts and nut traps will
 * adjust accordingly.
 */
hu_width = 20;

/**
 * The thickness of the rail. To give it some stability, I suggest
 * a thickness of at least 3mm.
 */
hu_thickness = 3;

/**
 * Distance between top and bottom of 1 HU to the first/last screw hole.
 * Within 1 HU, the holes are spaced evenly, but there is only 12.7mm or
 * 0.5" spacing between the last hole of 1 HU and the first hole of the
 * next.
 */
hu_top_bottom_spacing = (hu_height - 2 * hu_hole_spacing) / 2;

/**
 * Hole diameter for the screws to pass through. Specification demands
 * screws between UNF #10-32 (4.826mm) and UNF #12-24 (5.486mm). With these
 * plastic rails, use of a nut for securing a screw is neccessary, therefor
 * the diameter is slightly larger than the largest required screw.
 */
hu_hole_dia = 5.5;

/**
 * Screw holes will be slots that scale with the rail width. This margin is
 * the minimum amount of side margin that these slots will leave.
 */
hu_margin_width = 3.6;

/**
 * M5 nut outer diameter per DIN 934 / ISO 4032 plus some leeway.
 */
nut_diameter = 8.79;

/**
 * M5 nut thickness, minimum is 3.7mm plus a little leeway.
 */
nut_thickness = 4;

/**
 * The slack value is used for positioning parts so that they render
 * pristine in OpenSCAD preview.
 */
slack = 0.01;

/**
 * We want round circles by using a higher facet count.
 */
$fn = 128;

module rack_mount_rail_1_hu() {  
    difference() {
        cube([hu_width, hu_height, hu_thickness]);
        for(offset = [hu_top_bottom_spacing, hu_top_bottom_spacing + hu_hole_spacing, hu_top_bottom_spacing + 2 * hu_hole_spacing]) {
            translate([0, offset, -slack]) 
                hull() {
                    translate([hu_margin_width + hu_hole_dia / 2, 0, 0])
                        cylinder (d = hu_hole_dia, h = hu_thickness + 2 * slack);
                    translate([hu_width - hu_margin_width - hu_hole_dia / 2, 0, 0])
                        cylinder (d = hu_hole_dia, h = hu_thickness + 2 * slack);
                }
        }
    }
}

module nut_trap(height = 3, diameter = 6) {
    upscaleRatio = 1/cos(180/6);
    cylinder(r = (diameter * 0.97)/2 * upscaleRatio, h = height, $fn=6);
}

module rack_mount_rail_nut_trap_1_hu() {  
    difference() {
        cube([hu_width, hu_height, nut_thickness]);
        for(offset = [hu_top_bottom_spacing, hu_top_bottom_spacing + hu_hole_spacing, hu_top_bottom_spacing + 2 * hu_hole_spacing]) {
            translate([0, offset, -slack]) 
                hull() {
                    translate([hu_margin_width + hu_hole_dia / 2, 0, 0])
                        nut_trap(diameter = nut_diameter, height = nut_thickness + 2 * slack);
                    translate([hu_width, 0, 0])
                        nut_trap(diameter = nut_diameter, height = nut_thickness + 2 * slack);
                }
        }
    }
}

module rack_mount_rail(hu = 1) {
    for (i = [1 : hu]) {
        translate([0, (i - 1) * hu_height, 0]) {
            rack_mount_rail_1_hu();
        }
    }
}

module rack_mount_rail_nut_trap(hu = 1) {
    for (i = [1 : hu]) {
        translate([0, (i - 1) * hu_height, 0]) {
            rack_mount_rail_nut_trap_1_hu();
        }
    }
}
