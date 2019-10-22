use <rounded_box.scad>;

$fn = 32;

color("white") box_with_round_edges_3d([240, 165, 4], 10);

color ("black") 
    translate([26, 0, 4]) 
        linear_extrude(height = 1)
            resize([220, 0, 0], auto = true) 
            import(file = "apollo11_plaque.dxf");