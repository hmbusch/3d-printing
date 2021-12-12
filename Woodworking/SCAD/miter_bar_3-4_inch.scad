$fn = 16;
inch = 25.4;

height_adjustment = 0.95;

bar_length = 200;
bar_width_1 = inch * 3/4;
bar_width_2 = inch * 15/16;
bar_height_1 = inch * 3/8 * height_adjustment;
bar_height_2 = inch * 1/10;

desired_hole_offset = 20;
hole_spacing = 40;
hole_dia = 3.2;
screw_head_dia = 6;
screw_head_height = 3;

number_of_holes = round((bar_length - desired_hole_offset) / hole_spacing);
hole_offset = (bar_length - ((number_of_holes - 1) * hole_spacing)) / 2;

echo(str("<strong>Höhe gesamt      : ", bar_height_1, "</strong>"));
echo(str("<strong>Anzahl Bohrungen : ", number_of_holes, "</strong>"));
echo(str("<strong>Versatz Bohrungen: ", hole_offset, "</strong>"));

difference() {
    union() {
        translate([(bar_width_2 - bar_width_1) / 2, 0, 0])
            cube([bar_width_1, bar_length, bar_height_1]);
        cube([bar_width_2, bar_length, bar_height_2]);
    }
    
    translate([bar_width_2 / 2, hole_offset, 0]) {
        for(i = [0:number_of_holes - 1]) {
            translate([0, i * hole_spacing, 0]) {
                cylinder(d = hole_dia, h = bar_height_1);
                cylinder(d1 = screw_head_dia, d2 = hole_dia, h = screw_head_height);
            }
        }
    }
}