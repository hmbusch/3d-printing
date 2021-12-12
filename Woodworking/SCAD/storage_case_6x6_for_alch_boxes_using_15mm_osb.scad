sheet_width = 15;
inner_height = 76;

module a() {
    color("NavajoWhite")
        cube([330, sheet_width, inner_height]);
}

module b() {
    color("BurlyWood")
        cube([sheet_width, 360, inner_height + sheet_width]);
}
module c() {
    color("BlanchedAlmond")
        cube([360, 360, sheet_width]);
}

module d() {
    color("Wheat")
        cube([328, 360, sheet_width]);
}

c();
translate([0, 0, sheet_width]) {
    translate([sheet_width, 0, 0]) {
        a();
        translate([0, 360 - sheet_width, 0])
            a();
    }
    b();
    translate([360-sheet_width, 0, 0])
        b();
}
translate([sheet_width + 1, 0, inner_height + sheet_width])
    #d();

