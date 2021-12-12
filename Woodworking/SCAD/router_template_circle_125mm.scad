dia = 127;
offset = 20;
height = 10;

$fn = 128;

difference() {
    cylinder(d = 2 * offset + dia, h = height);
    cylinder(d = dia, h = height);
}
