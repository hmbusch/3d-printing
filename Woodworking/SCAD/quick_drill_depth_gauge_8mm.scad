$fn = 64;

module depthGauge11mm() {
    difference() {
        cube([20, 43, 18]);
        translate([10, 43/2, 7])
            cylinder(d = 8.2, h = 11);
        translate([10, 43/2, 2])
            cylinder(d = 2, h = 7);
        translate([10/5, 43/4, 17])
            linear_extrude(height = 1.5)
                text("Ø 8mm", 4, "Calibri:style=Regular");
        translate([10/5 + 2, 1, 16])
            rotate([90, 90, 0])
                linear_extrude(height = 1.5)
                    text("|----->", 4, "Calibri:style=Regular");   
        translate([11, 1, 16])
            rotate([90, 90, 0])
                linear_extrude(height = 1.5)
                    text("11mm", 4, "Calibri:style=Regular");        
    }
}

module depthGauge31mm() {
    difference() {
        cube([20, 43, 40]);
        translate([10, 43/2, 9])
            cylinder(d = 8.2, h = 31);
        translate([10, 43/2, 2])
            cylinder(d = 2, h = 9);
        translate([10/5, 43/4, 39])
            linear_extrude(height = 1.5)
                text("Ø 8mm", 4, "Calibri:style=Regular");
        translate([10/5 + 2, 1, 38])
            rotate([90, 90, 0])
                linear_extrude(height = 1.5)
                    text("|------------------>", 4, "Calibri:style=Regular");   
        translate([11, 1, 38])
            rotate([90, 90, 0])
                linear_extrude(height = 1.5)
                    text("31mm", 4, "Calibri:style=Regular");        
    }
}

depthGauge11mm();
translate([30, 0, 0])
    depthGauge31mm();
