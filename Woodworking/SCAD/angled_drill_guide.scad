board_thickness = 15;
tool_thickness = 6;
tool_height = 20;
drill_diameter = 3.1;
angle = 25;
$fn = 64;

// Derived values, do not edit
a = (3 * tool_thickness + board_thickness);
b = a * tan(angle);

module angledWedge() {        
    linear_extrude(height = tool_height)
        polygon([[0,0], [a, 0], [0, b]]);
}


difference() {
    union() {
        cube([board_thickness, 3 * tool_thickness, tool_height]);        
        translate([- 3 * tool_thickness, 3 * tool_thickness, 0])
            angledWedge();
    }
    translate([board_thickness/2, 6 * tool_thickness, tool_height/2])
        rotate([90, 0, 0]) 
            cylinder(d = drill_diameter, h = 7 * tool_thickness);
}
translate([board_thickness, 0 , 0])
    cube([tool_thickness, 10 * tool_thickness, tool_height]);


    