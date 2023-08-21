include <rounded_box.scad>;

Glass_X = 110.5;
Glass_Y = 90.5;
Glass_Z = 3.5;

Wall_Thickness = 2;
Handle_Width = 20;

Holder_X = Glass_X + 2 * Wall_Thickness;
Holder_Y = Glass_Y + 2 * Wall_Thickness;
Holder_Z = Glass_Z + Wall_Thickness;

Cover_Airgap = 0.1;

f = 0.01;
df = 2 * f;

$fn = 64;

module glass() {
    color("brown") #cube([Glass_X, Glass_Y, Glass_Z]);
}

module frame() {
    difference() {
        cube([Holder_X, Holder_Y, Holder_Z]);
        translate([Wall_Thickness, Wall_Thickness, Wall_Thickness])
            cube([Glass_X, Glass_Y, Glass_Z + f]);
        translate([Wall_Thickness * 2, Wall_Thickness * 2, -f])
            cube([Glass_X - 2 * Wall_Thickness, Glass_Y - 2 * Wall_Thickness, Wall_Thickness + df]);
    }
}

Cover_X = Holder_X + 2 * Cover_Airgap + 2 * Handle_Width;
Cover_Y = Holder_Y + 2 * Cover_Airgap + 2 * Wall_Thickness;
Cover_Z = Holder_Z + Cover_Airgap + Wall_Thickness;

module cover_with_handles() {
    difference() {
        box_with_round_edges_3d([Cover_X, Cover_Y, Cover_Z], edge_radius = 5);
        translate([Handle_Width, Wall_Thickness, Wall_Thickness + Cover_Airgap])
            cube([Holder_X + 2 * Cover_Airgap, Holder_Y + 2 * Cover_Airgap, Holder_Z + f]);
        translate([Handle_Width + Cover_Airgap + 2* Wall_Thickness, 3 * Wall_Thickness, -f])
            cube([Holder_X - 4 * Wall_Thickness, Holder_Y - 4 * Wall_Thickness, Wall_Thickness + Cover_Airgap + df]);
    }
}


module assembly() {
    color("gray") frame();
    translate([Wall_Thickness, Wall_Thickness, Wall_Thickness])
        glass();

    translate([-Handle_Width, Cover_Y - Wall_Thickness, Holder_Z + Wall_Thickness])
        rotate([180, 0, 0])
            color("darkgray") cover_with_handles();
}

module print() {
    frame();    
    translate([(Holder_X - Cover_X)/2, Cover_Y, 0])
        cover_with_handles();
}

print();


