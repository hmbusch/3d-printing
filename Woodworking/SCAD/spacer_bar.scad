$fn = 64;

difference() {
    cube([200, 30, 12.5]);
    translate([5, 1, 4.5])
        rotate([90, 0, 0])
            linear_extrude(height = 1.5)
                text("|--------> 200mm", 4, "Calibri:style=Regular");   
    translate([110, 1, 0])
        rotate([0, -90, 90])
            linear_extrude(height = 1.5)
                text("|->", 4, "Calibri:style=Regular");   

    translate([100, 1, 7.5])
        rotate([90, 0, 0])
            linear_extrude(height = 1.5)
                text("12.5mm", 4, "Calibri:style=Regular");   
    
    translate([14, 4, 11.5])
        rotate([0, 0, 90])
            linear_extrude(height = 1.5)
                text("|------->", 4, "Calibri:style=Regular");   

    translate([5, 23, 11.5])
        linear_extrude(height = 1.5)
            text("30mm", 4, "Calibri:style=Regular");  
}

