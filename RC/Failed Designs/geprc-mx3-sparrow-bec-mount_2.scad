standoff_diameter = 4.1;

$fn = 64;

difference() {
    union() {
        cylinder(d = standoff_diameter + 2.4, h = 16);
        translate([0 ,(standoff_diameter) / 2, 0]) cube([25, 1.2, 16]);
        translate([6, standoff_diameter / 2 + 1.2, 0]) cube([1.2, 2, 16]);
        translate([6 + 9 + 1.2, standoff_diameter / 2 + 1.2, 0]) cube([1.2, 2, 16]);
    }
    translate([0, 0, -0.1]) cylinder(d = standoff_diameter, h = 16.2);
    
    translate([4.5, standoff_diameter / 2 - 0.5, 6]) cube([1.5, 2, 4]);
    translate([17.4, standoff_diameter / 2 - 0.5, 6]) cube([1.5, 2, 4]);
}
