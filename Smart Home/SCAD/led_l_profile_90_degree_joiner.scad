profile_thickness = 1.5;
profile_width = 20;
profile_height = 10;
profile_length = 30;

module l_profile() {
    cube([profile_length, profile_width, profile_thickness]);
    cube([profile_length, profile_thickness, profile_height]);
}

module l_profile_angled_1() {
    difference() {
        l_profile();
        linear_extrude(height = profile_height)
            polygon([[0,0], [0, profile_width], [profile_width, profile_width]]);
    }
}

module l_profile_angled_2() {
    difference() {
        l_profile();
        linear_extrude(height = profile_height)
            polygon([[30,0], [30, profile_width], [30 - profile_width, profile_width]]);        
    }
}

module joiner() {
    linear_extrude(height = profile_height)
        polygon([
            [0,0], 
            [0,1], 
            [profile_thickness, 1 + profile_thickness], 
            [profile_thickness, profile_thickness], 
            [1 + profile_thickness, profile_thickness], 
            [1,0]]);
    linear_extrude(height = profile_thickness)
        polygon([
            [profile_thickness, 1 + profile_thickness], 
            [profile_width, profile_width + 1], 
            [profile_width, profile_width],
            [profile_width + 1, profile_width], 
            [profile_thickness + 1, profile_thickness], 
            [profile_thickness, profile_thickness]]);
    translate([profile_thickness, profile_thickness, profile_thickness]) {
        cube([profile_width - profile_thickness, profile_width - profile_thickness, 0.8]);
        cube([profile_width - profile_thickness, 1.2, profile_height - profile_thickness]);
        cube([1.2, profile_width - profile_thickness, profile_height - profile_thickness]);
    }    
}

//#translate([1, 0, 0]) l_profile_angled_1();
//#translate([0, 31, 0]) rotate([0, 0, -90]) l_profile_angled_2();


joiner();



