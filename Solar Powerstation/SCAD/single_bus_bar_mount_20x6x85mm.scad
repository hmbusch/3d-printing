/* [Conductor Settings] */

// Length of the conductor
Bus_Bar_Length = 90; // [50:200]

// Width of the conductor
Bus_Bar_Width = 20; // [10:40]

// Width of the conductor
Bus_Bar_Height = 6; // [2:20]

/* [Post Settings] */

// Diameter of the small posts
Small_Post_Size = 5; // [5:M5, 6:M6, 8:M8, 10:M10]

// The length of your screws for the small posts
Small_Post_Length = 22; // [10:30]

// The minimum amount of thread of the small posts you want to be usable
Small_Post_Min_Thread = 10; // [5:30]

// Diameter of the large post
Large_Post_Size = 8; // [6:M6, 8:M8, 10:M10]

// The length of your screws for the large post
Large_Post_Length = 25; // [10:50]

// The minimum amount of thread of the large post you want to be usable
Large_Post_Min_Thread = 14; // [5:30]

/* [Base Settings] */

// Thickness of the non-conducting base, measured from top of the screw heads
Base_Height = 5; // [3:10]

// The amount the base will be larger than the bus bar itself (bar will be centered)
Base_Offset = 4; // [0:30]

// The posts will be raised from the "floor" by this amount
Base_Post_Offset = 1; // [0:10]

// The diameter of the mounting holes of the base
Base_Mounting_Hole = 5.1;

// The size of the mounting support
Base_Mounting_Support = 12;

/* [Drill Guide] */

// Do you want/need a drill guide for the bus bar?
Drill_Guide_Enabled = "yes"; // [yes, no]

// Thickness of the drill guide
Drill_Guide_Thickness = 2; // [1:10]

// Diameter of the marking hole for the large post
Drill_Guide_Large_Hole = 1.5; // [1:0.5:10]

// Diameter of the marking hole for the small posts
Drill_Guide_Small_Hole = 1.5; // [1:0.5:10]

/* [Hidden] */
// Screw head sizes for posts as a lookup table, using post diameter as index
Screw_Head_Sizes = [0, 0, 0, 0, 0, 8.1, 10.1, 0, 13.1, 0, 17.1];

// Height of the screw head to completely sink them into the base
Screw_Head_Heights = [0, 0, 0, 0, 0, 4, 5, 0, 6, 0, 7];

// Contact space for each post in relation to post diameter
Contact_Pad_Sizes = [0, 0, 0, 0, 0, 16, 20, 0, 26, 0, 34];

// The number of segments in a curve/circle (i.e. smoothness of curved surfaces)
$fn = 64;

Required_Bar_Length = 4 * Contact_Pad_Sizes[Small_Post_Size] + Contact_Pad_Sizes[Large_Post_Size];

Additional_Pad_Size = (Bus_Bar_Length - Required_Bar_Length) / 5;

Small_Pad_Size = Contact_Pad_Sizes[Small_Post_Size] + Additional_Pad_Size;

Large_Pad_Size = Contact_Pad_Sizes[Large_Post_Size] + Additional_Pad_Size;

// Small amount of offset for better rendering
f = 0.01;

df = 2*f;


/**
 * Conducts a series of checks to ensure that the parameters selected by the user
 * don't result in an unusable or unprintable result.
 */
module plausibilityChecks() {
    echo();
    echo(str("Small post diameter/length/min. thread: ", Small_Post_Size, "mm/", Small_Post_Length, "mm/", Small_Post_Min_Thread, "mm"));
    echo(str("Large post diameter/length/min. thread: ", Large_Post_Size, "mm/", Large_Post_Length, "mm/", Large_Post_Min_Thread, "mm"));    
    
    echo();
    
    echo(str("Small contact pad: ", Contact_Pad_Sizes[Small_Post_Size], "mm")); 
    echo(str("Large contact pad: ",  Contact_Pad_Sizes[Large_Post_Size], "mm"));
    
    echo(str("Minimum required bar length: ", Required_Bar_Length, "mm"));
    
    assert(Bus_Bar_Length >= Required_Bar_Length, str("Bus bar must be at least ", Required_Bar_Length, "mm long to accommodate the chosen post sizes"));
    
    if (Additional_Pad_Size > 0) {
        echo();
        echo(str("Additional pad size to fill bus bar evenly: ", Additional_Pad_Size, "mm"));
        echo(str("Effective small pad size: ", Small_Pad_Size, "mm"));
        echo(str("Effective large pad size: ", Large_Pad_Size, "mm"));
    }

    small_length_difference = Small_Post_Length - Small_Post_Min_Thread - Base_Height -Bus_Bar_Height;
        
    assert(small_length_difference >= 0, str("The screws for the small posts are too short to provide ", Small_Post_Min_Thread, "mm of minimum usable thread length with a base height of ", Base_Height, "mm and a conductor thickness of ", Bus_Bar_Height, "mm. Either use longer screws or reduce the minimum thread size or reduce the base height or use a thinner conductor. You are missing ", abs(small_length_difference), "mm."));
    
    large_length_difference = Large_Post_Length - Large_Post_Min_Thread - Base_Height - Bus_Bar_Height;

    assert(large_length_difference >= 0, str("The screw for the large post is too short to provide ", Large_Post_Min_Thread, "mm of minimum usable thread length with a base height of ", Base_Height, "mm and a conductor thickness of ", Bus_Bar_Height, "mm. Either use a longer screw of reduce the minimum thread size or reduce the base height or use a thinner conductor. You are missing ", abs(small_length_difference), "mm."));
    
    assert(Base_Mounting_Support > Base_Mounting_Hole * 2, str("The mounting support is too small for the mounting screws, should be at least 2 times the screw diameter ", Base_Mounting_Hole, " * 2 = ", Base_Mounting_Hole * 2));
    
    echo();
    
    echo("All plausibility checks passed ... OK");
    
    echo();
}

/**
 * Creates a positive model of a trap for a hex screw with screw head and 
 * thread. Can then be subtracted from a body to create the trap.
 */
module hex_screw_trap(screw_diameter, screw_head_size, screw_length, screw_head_trap_height) {
    $fn = 64;
    upscaleRatio = 1/cos(180/6);
    cylinder(r = (screw_head_size*0.99)/2 * upscaleRatio, h = screw_head_trap_height, $fn=6);
    translate([0, 0, screw_head_trap_height - f]) 
        cylinder(d = screw_diameter + 0.2, h = screw_length);
}

module base() {
    x_offset = Base_Offset / 2;
    y_offset = Base_Offset / 2;
    
    max_screw_head_height = max(Screw_Head_Heights[Small_Post_Size], Screw_Head_Heights[Large_Post_Size]);
    
    base_x = Bus_Bar_Length + 2 * Base_Offset;
    base_y = Bus_Bar_Width + 2 * Base_Offset;
    base_z = max_screw_head_height + Base_Post_Offset + Base_Height;
    
    difference() {
        cube([base_x, base_y, base_z]);
        
        // large post
        translate([base_x/2, base_y/2, -f])
            hex_screw_trap(Large_Post_Size, Screw_Head_Sizes[Large_Post_Size], Large_Post_Length + f, Screw_Head_Heights[Large_Post_Size] + Base_Post_Offset + f);
        
        // small posts
        for(pos = [1, 2]) {
            post_x_offset = base_x/2 + Large_Pad_Size / 2 + pos * Small_Pad_Size - Small_Pad_Size / 2;
            neg_post_x_offset = base_x/2 - Large_Pad_Size / 2 - pos * Small_Pad_Size + Small_Pad_Size / 2;
            translate([post_x_offset, base_y/2, -f])
                hex_screw_trap(Small_Post_Size, Screw_Head_Sizes[Small_Post_Size], Small_Post_Length + f, Screw_Head_Heights[Small_Post_Size] + Base_Post_Offset + f);
            translate([neg_post_x_offset, base_y/2, -f])
                hex_screw_trap(Small_Post_Size, Screw_Head_Sizes[Small_Post_Size], Small_Post_Length + f, Screw_Head_Heights[Small_Post_Size] + Base_Post_Offset + f);
        }
    }
    difference() {
        translate([-Base_Mounting_Support, (base_y - Base_Mounting_Support)/2, 0])
            cube([Base_Mounting_Support, Base_Mounting_Support, base_z/2]);
        translate([-Base_Mounting_Support/2, base_y/2, -f])
            cylinder(d = Base_Mounting_Hole, h = base_z/2 + df);
    }
    difference() {
        translate([base_x, (base_y - Base_Mounting_Support)/2, 0])
            cube([Base_Mounting_Support, Base_Mounting_Support, base_z/2]);
        translate([base_x + Base_Mounting_Support/2, base_y/2, -f])
            cylinder(d = Base_Mounting_Hole, h = base_z/2 + df);
    }    
    
}

module drill_guide() {
    difference() {
        cube([Bus_Bar_Length, Bus_Bar_Width, Drill_Guide_Thickness]);
        
        $fn = 64;
        
        // large post
        translate([Bus_Bar_Length/2, Bus_Bar_Width/2, -f])
            cylinder(d = Drill_Guide_Large_Hole, h = Drill_Guide_Thickness + 2 * f);
        
        // small posts
        for(pos = [1, 2]) {
            post_x_offset = Bus_Bar_Length/2 + Large_Pad_Size / 2 + pos * Small_Pad_Size - Small_Pad_Size / 2;
            neg_post_x_offset = Bus_Bar_Length/2 - Large_Pad_Size / 2 - pos * Small_Pad_Size + Small_Pad_Size / 2;
            translate([post_x_offset, Bus_Bar_Width/2, -f])
                cylinder(d = Drill_Guide_Small_Hole, h = Drill_Guide_Thickness + 2 * f);
            translate([neg_post_x_offset, Bus_Bar_Width/2, -f])
                cylinder(d = Drill_Guide_Small_Hole, h = Drill_Guide_Thickness + 2 * f);
        }
    }
}

plausibilityChecks();
base();
if (Drill_Guide_Enabled == "yes") {
    translate([0, Bus_Bar_Width + 2 * Base_Offset + 10, 0])
        drill_guide();
}

