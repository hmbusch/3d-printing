$fn=128;

color("White") {
    cube([60, 16, 1]);
    translate([20, 16, 0])
        cube([20, 20, 1]);
}

translate([2.5, 7, 1])
    color("Black")
    linear_extrude(height=0.6) 
    text(text = "Sumpmann", size = 8, valign = "center", font = "Cabin:style=Bold");