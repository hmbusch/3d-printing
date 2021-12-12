sehnenmittelpunkt_a = 5.5;
sehne_s = 41;

radius = (4 * pow(sehnenmittelpunkt_a, 2) + pow(sehne_s, 2))/(8 * sehnenmittelpunkt_a);

echo("Radius: ", radius);

hoehe = 20;
tiefe = 30;

$fn = 128;

module positiv() {
    translate([0, -(radius - tiefe), 0])
        intersection() {
            cylinder(r = radius, h = hoehe);
            translate([-sehne_s/2, radius - tiefe, 0])
                cube([sehne_s, tiefe, hoehe]);
            }
}

module negativ() {
    difference() {
        translate([-sehne_s/2, tiefe-10, 0])
            cube([sehne_s, tiefe, hoehe]);
        positiv();
    }
}

positiv();
translate([0, 10, 0])
    negativ();