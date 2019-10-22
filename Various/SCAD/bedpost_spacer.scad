abstandshalter_dicke_1 = 7;
abstandshalter_dicke_2 = 3;
abstandshalter_hoehe = 50;
abstandshalter_breite = 26;

bohrung_breite = 11;
bohrung_hoehe = 26;
bohrung_tiefe = abstandshalter_dicke_1 * 2;

rohr_durchmesser = 45;
rohr_hoehe = 1.2 * abstandshalter_hoehe;

stuetzwand_hoehe = 10;
stuetzwand_breite = 46;
stuetzwand_tiefe = 5;
stuetzwand_dicke = 1;

$fn = 64;

module abstandshalter() {
    cube([abstandshalter_breite, abstandshalter_dicke_1, abstandshalter_hoehe]);
}

module rohr() {
    cylinder(d = rohr_durchmesser, h = rohr_hoehe);
}

module bohrung() {
    translate([0, bohrung_tiefe / 2, bohrung_breite / 2])
    rotate([0, -90, -90])
    hull() {
        cylinder(d = bohrung_breite, h = bohrung_tiefe);
        translate([bohrung_hoehe - bohrung_breite, 0, 0]) cylinder(d = bohrung_breite, h = bohrung_tiefe);
    }
}

module assembly() {
    offset_x = abstandshalter_breite / 2;
    offset_y = rohr_durchmesser / 2 + abstandshalter_dicke_2;
    offset_z = - (rohr_hoehe - abstandshalter_hoehe) / 2; 

    difference() {
        abstandshalter();
        translate([offset_x, offset_y, offset_z]) rohr();
        translate([abstandshalter_breite / 2, bohrung_tiefe * -0.75, (abstandshalter_hoehe - bohrung_hoehe) / 2]) bohrung();
        stuetzwand_scale = 1.25;
        stuetzwand_offset = stuetzwand_dicke * (stuetzwand_scale - 1) / 2;
        translate([1.5 - stuetzwand_offset + stuetzwand_dicke, 0.6, abstandshalter_hoehe - (abstandshalter_hoehe - stuetzwand_breite) / 2]) 
            rotate([90, 90, 0]) 
                stuetzwand(stuetzwand_scale);
        mirror([1, 0, 0])
            translate([-abstandshalter_breite + 1.5 - stuetzwand_offset + stuetzwand_dicke, 0.6, abstandshalter_hoehe - (abstandshalter_hoehe - stuetzwand_breite) / 2]) 
                rotate([90, 90, 0]) 
                    stuetzwand(stuetzwand_scale);
    }
    
    translate([30, stuetzwand_hoehe, stuetzwand_breite]) rotate([90, 90, 0]) stuetzwand();
    translate([40, stuetzwand_hoehe, stuetzwand_breite]) rotate([90, 90, 0]) stuetzwand();
}

module klemmrohr() {
    hull() {
        translate([stuetzwand_dicke, 0, 0]) sphere(d = 2 * stuetzwand_dicke);
        translate([stuetzwand_breite - 3 * stuetzwand_dicke, 0, 0]) sphere(d = 2 * stuetzwand_dicke);
    }
}
    
module stuetzwand(scale = 1) {
    cube([stuetzwand_breite, scale * stuetzwand_dicke, stuetzwand_hoehe]);
    cube([scale * stuetzwand_dicke, stuetzwand_tiefe, stuetzwand_hoehe]);
    translate([stuetzwand_breite - stuetzwand_dicke, 0, 0]) cube([scale * stuetzwand_dicke, stuetzwand_tiefe, stuetzwand_hoehe]);

    translate([stuetzwand_dicke, 0, stuetzwand_hoehe - 2 * stuetzwand_dicke]) {
        klemmrohr();
        translate([0, 0, -3]) klemmrohr();
        translate([0, 0, -6]) klemmrohr();
    }
    
    for (offset_x = [0, stuetzwand_breite]) {
        for (offset_z = [2, 5, 8]) {
            translate([offset_x, stuetzwand_tiefe / 2, offset_z]) sphere(d = stuetzwand_dicke * 2);
        }
    }
}

assembly();