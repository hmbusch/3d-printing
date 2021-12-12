$fn = 64;

profile_thickness = 1.5;
profile_width = 20;
screw_offset = 4;

fudge = 0.1;

nf = -fudge;
dpf = 2 * fudge;

module spacer(height) {
    difference() {
        cube([profile_width, profile_width, height]);
        translate([profile_width / 2, profile_thickness +  screw_offset, nf]) cylinder(d = 3.5, h = height + dpf);
    }
}

for(x = [1:7]) {
    for(y = [1:3]) {
        translate([(x-1) * 1.5 * profile_width, (y-1) * 1.5 * profile_width, 0])
            spacer(x);
    }    
}