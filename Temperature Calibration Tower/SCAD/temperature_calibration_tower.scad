/* [Global] */

// The highest temperature to include
temp_high = 220; //[210:5:280]

// The lowest temperature to include
temp_low = 180; //[140:5:205]

// Filament name
filament = "PrimaValue PLA";

/* [Hidden] */

// Height of each temperature step in mm
step_height = 10;

$fn = 32;

module step(label = "???", step_height = 8) {
    difference() {
        union() {
            // base cube
            cube([20, 20, step_height]);
            // add overhang noses
            translate([0, 15, step_height/2]) rotate([0, -90, 0]) rotate([0, 0, 45]) cylinder(d1 = step_height, d2 = 0, h = 5, $fn=4);
            translate([0, 5, step_height/2]) rotate([0, -90, 0]) cylinder(d1 = step_height, d2 = 0, h = 5, $fn=4);            
            // add temperature label
            translate([20, 1, 5]) rotate([90, 0, 90]) linear_extrude(height = 0.8) resize([17, 7]) text(text = label, size = 2.2, valign = "center", font = "sans-serif");    
        }
        // slot to seperate segments visually
        rotate([-90, 0, 0]) cylinder(d = 1, h = 20);
        // cutout to test bridging
        translate([8, 0, 1]) cube([10, 20, step_height - 2]);
    }
}

union() {
    total_steps = (temp_high - temp_low) / 5;
    total_height = total_steps * step_height;
    label_height = total_height * 0.9;
    
    // Create tower
    for(temp = [temp_high:-5:temp_low]) {
        step_count = abs(temp - temp_high) / 5;
        translate([0, 0, step_count * step_height]) step(str(temp), step_height);
    }    
    // Add filament label
    translate([4, 0, total_height * 0.1]) rotate([0, -90, 90]) linear_extrude(height = 0.8) resize([label_height, 6]) text(text = filament, size = 2.2, valign = "center", font = "sans-serif");    
}