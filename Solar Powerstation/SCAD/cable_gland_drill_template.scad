cable_gland_screw_dia = 16;
cable_gland_turn_dia = 22;
hole_spacing = 0;
initial_drill_size = 2;
template_thickness = 3;

f = 0.01;
df = f * 2;
$fn = 128;

module template(hole_dia) {
    difference() {
        x_width = 4 + 2 * cable_gland_turn_dia + hole_spacing;
        x_offset = (x_width - cable_gland_turn_dia - hole_spacing)/2;
        cube([4 + 2 * cable_gland_turn_dia + hole_spacing, 1.5 * cable_gland_turn_dia, template_thickness]);
        translate([x_offset, 0.75 * cable_gland_turn_dia, -f]) {
            cylinder(d = hole_dia, h = template_thickness + df);
            translate([cable_gland_turn_dia + hole_spacing, 0, 0])
                cylinder(d = hole_dia, h = template_thickness + df);
        }
    }
}

template(cable_gland_screw_dia);
translate([0, 2 * cable_gland_turn_dia, 0])
    template(initial_drill_size);