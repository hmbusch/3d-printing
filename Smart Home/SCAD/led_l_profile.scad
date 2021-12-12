$fn = 64;

profile_thickness = 1.5;
profile_width = 20;
profile_height = 10;
profile_length = 150;

module peg() {
    translate([7, 0, 0]) cylinder(d = 8, h = profile_thickness);
    translate([0, -2.5, 0]) cube([5, 5, profile_thickness]);
}

module peg_male_right() {
    translate([profile_length, profile_width/2, 0]) scale([1, 0.98, 1]) peg();
}

module peg_male_left() {
    translate([0, profile_width/2, 0]) mirror([1, 0, 0]) scale([1, 0.98, 1]) peg();
}

module peg_female_right() {
    translate([profile_length, profile_width/2, -0.1]) mirror([1, 0, 0]) scale([1, 1, 1.2]) peg();
}

module peg_female_left() {
    translate([0, profile_width/2, -0.1]) scale([1, 1, 1.2]) peg();
}

module l_profile() {
    cube([profile_length, profile_width, profile_thickness]);
    cube([profile_length, profile_thickness, profile_height]);
}


module l_profile_part(peg_right, peg_left) {
    
    if(peg_right == "male" && peg_left == "female") {
        difference() {
            union() {
                l_profile();
                peg_male_right();                
            }
            peg_female_left();
        }
    } else if (peg_right == "male" && peg_left == "male") {
        l_profile();
        peg_male_right();
        peg_male_left();
    } else if (peg_right == "female" && peg_left == "female")  {
        difference() {
            l_profile();
            peg_female_right();
            peg_female_left();
        }
    } else if (peg_right == "female" && peg_left == "male") {
        difference() {
            union() {
                l_profile();
                peg_male_left();
            }
            peg_female_right();
        }
    } else if (peg_right == "none" && peg_left == "male") {
        l_profile();
        peg_male_left();
    } else if (peg_right == "none" && peg_left == "female") {
        difference() {
            l_profile();
            peg_female_left();
        }
    } else if (peg_right == "male" && peg_left == "none") {
        l_profile();
        peg_male_right();
    } else if (peg_right == "female" && peg_left == "none") {
        difference() {
            l_profile();
            peg_female_right();
        }
    } else if (peg_right == "none" && peg_left == "none") {
        l_profile();
    } else {
        echo ("<span style='font-weight:bold; color: red'>ERROR: You made an invalid choice for 'peg_right' and/or 'peg_left'. Valid settings are 'male', 'female', 'none'.</span>");
    }
}

l_profile_part("none", "male");
translate([0, profile_width + 10, 0]) l_profile_part("female", "none");