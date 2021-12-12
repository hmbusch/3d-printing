fudge = 0.01;
clip_width = 5;
clip_height = 3;
clip_length = 12;

slot_width = 1.5;
slot_length = 10;

// Derived values, do not edit
pf = fudge;
dpf = 2 * pf;
nf = -pf;


difference() {
    cube([clip_width, clip_length, clip_height]);
    translate([(clip_width - slot_width)/2, nf, nf]) cube([slot_width, slot_length + pf, clip_height + dpf]);
}