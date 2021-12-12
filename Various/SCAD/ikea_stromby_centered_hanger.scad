$fn = 64;
frame_depth = 14.5;
frame_lip = 5;
frame_lip_overhang = 4.6;
slack = 0.01;

difference() {
    union() {
        cube([80, 30, 14.5]);
        translate([0, 30, frame_lip])
            cube([80, frame_lip_overhang, frame_depth - frame_lip]);
    }
    for(i = [0:8]) {
        translate([20 + 5 * i, 16, 0])
            cylinder(d = 5.5, h = frame_depth + slack);
    }
    translate([20 - 5.5/2, 10, 0])
        cube([40 + 5.5, 6, frame_depth + slack]);
    translate([20 - 5.5/2, 15, 7])
        cube([40 + 5.5, 6, frame_depth]);    
}    