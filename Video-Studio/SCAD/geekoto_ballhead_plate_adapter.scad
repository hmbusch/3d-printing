// Diameter of the stem on the ballhead
Stem_Diameter = 15.1;

// Diameter of the screw hole in the ballhead stem
Stem_Hole_Diameter = 7;

// Width of the stem notch
Stem_Notch_Width = 4.3;

// Height of the stem notch
Stem_Notch_Height = 1.9;

// Height of the ballhead mating plate
Stem_Mating_Height = 3;

// Diameter of the screw hole in the lock plate
Plate_Hole_Diameter = 10.1;

// Width of the lock plate notch
Plate_Notch_Width = 3;

// Depth of the lock plate notch
Plate_Notch_Depth = 1.4;

// Mating surface diameter
Plate_Mating_Diameter = 26;

// Height of the adapter mating plate
Plate_Mating_Height = 2;

/* [Hidden] */
$fn = 64;
f = 0.01;
df = f*2;

module utebit_plate_adapter() {
    difference() {
        union() {
            cylinder(d = Plate_Mating_Diameter, h = Plate_Mating_Height);
            translate([-Plate_Notch_Width/2, -Plate_Mating_Diameter/2, Plate_Mating_Height])
                cube([Plate_Notch_Width, Plate_Mating_Diameter, Plate_Notch_Depth]);
        }
        translate([0, 0, -f])
            cylinder(d = Plate_Hole_Diameter, h = Plate_Mating_Height + Plate_Notch_Depth + df);
        difference() {
            cylinder(d = Plate_Mating_Diameter * 1.1, h = Plate_Mating_Height + Plate_Notch_Depth + df);
            cylinder(d = Plate_Mating_Diameter, h = Plate_Mating_Height + Plate_Notch_Depth + df);
        }
    }
}

module geekoto_ballhead_adapter() {
    difference() {
        difference() {
            cylinder(d = Stem_Diameter, h = Stem_Mating_Height);
            translate([-Stem_Notch_Width/2, -Stem_Diameter/2, Stem_Mating_Height - Stem_Notch_Height + f])
                cube([Stem_Notch_Width, Stem_Diameter, Stem_Notch_Height]);
        }
        translate([0, 0, -f])
            cylinder(d = Stem_Hole_Diameter, h = Stem_Notch_Height + Stem_Mating_Height + df);         
    }
}

module geekoto_ballhead_adapter_low_profile() {
    difference() {
        difference() {
            cylinder(d = Stem_Diameter, h = Stem_Notch_Height);
            translate([-Stem_Notch_Width/2, -Stem_Diameter/2, -f])
                cube([Stem_Notch_Width, Stem_Diameter, Stem_Notch_Height + df]);
        }
        translate([0, 0, -f])
            cylinder(d = Stem_Hole_Diameter, h = Stem_Notch_Height + Stem_Mating_Height + df);         
    }
    difference() {
        cylinder(d = Plate_Mating_Diameter, h = Stem_Notch_Height);
        translate([0, 0, -f])
            cylinder(d = Stem_Diameter, h = Stem_Notch_Height + df);
    }
        
}

module geekoto_ballhead_to_utebit_plate_adapter() {
    geekoto_ballhead_adapter();
    rotate([180, 0, 0])
        utebit_plate_adapter();
}

geekoto_ballhead_to_utebit_plate_adapter();
translate([Plate_Mating_Diameter * 1.5, 0, 0])
    geekoto_ballhead_adapter_low_profile();