// PRUSA iteration3
// Extruder-body
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org


use <extruder-main.scad>

// Parameters for different sizes of Inductive probes
// Width of probe
probe_width = 12;

//Adjustment for entire center of holder in addition to deviation already. In general, make this the size difference from 8mm of your probe, divided by 2
center_adjustment = 2;

module m3nut()
{
difference()
{
cube([2,6,8]);
translate([-0.5,3,3]) rotate([0,90,0]) cylinder(r=1.25, h=3, $fn=20);
}
}


module ext_body(){

    difference(){
       extruder_body();
       extruder_mount_holes();

        // PINDA entry hole
        //translate([-(5.5+center_adjustment),37,6+center_adjustment])rotate([90,0,0])cylinder(r=probe_width+0.4, h=4, $fn=20);
    }

}


difference()
{
ext_body();

    // remove old pinda
    translate([-20,26,-2]) cube([20,30,30]);

    // screw end larger hole
    translate([-20,40,12])rotate([0,90,0])cylinder(r=1.5, h=24, $fn=20);
    translate([2,40,11.5])rotate([0,90,0])cylinder(r=1.5, h=3, $fn=20);
    translate([2,40,12])rotate([0,90,0])cylinder(r=1.5, h=3, $fn=20);
    translate([2,40,12.5])rotate([0,90,0])cylinder(r=1.5, h=3, $fn=20);

    // M3 nuts
    translate([0,46,9]) m3nut()
    translate([0,37,9]) m3nut();
    // Nut from PINDA
    translate([0,38,9+center_adjustment*2]) m3nut();

}

// Creation of PINDA probe holder
module ex_body()
{

translate([-5, 0, 0]) difference()
{

    union()
    {
        // body
        // round body
        translate([-5.5,36.5,6])rotate([-90,0,0])cylinder(r=probe_width+0.5, h=19, $fn=20);

        // body block
        translate([-15,36.5,5+center_adjustment*2]) cube([19,19,10.5]);
        translate([-13,36.5,15]) cube([5,19,1]);

        // extruder body joint
        translate([-0,33.5,0]) cube([3,2,15]);
        translate([0,34,0]) cube([4,3,15]);
        translate([0,35.5,0]) rotate([0,0,45]) cube([2,2,15]);
        translate([2.5, 35, 0]) cube([4, 9, 12]);
    }


    // PINDA lower hole
    translate([-(5.5+center_adjustment),50,6+center_adjustment])rotate([-90,0,0])cylinder(r=(probe_width/2)+0.1, h=40, $fn=20);

    // M3 screws
    translate([-20,49,12+center_adjustment*2])rotate([0,90,0])cylinder(r=1.5, h=24, $fn=20);
    translate([-20,41,12+center_adjustment*2])rotate([0,90,0])cylinder(r=1.5, h=24, $fn=20);
    translate([-(14+center_adjustment*2),49,12+center_adjustment*2])rotate([0,90,0])cylinder(r=3, h=5, $fn=20);
    translate([-(14+center_adjustment*2),41,12+center_adjustment*2])rotate([0,90,0])cylinder(r=3, h=5, $fn=20);

    // lower M3 screw end opening
    translate([2,49,11.5+center_adjustment*2])rotate([0,90,0])cylinder(r=1.5, h=3, $fn=20);
    translate([2,49,12+center_adjustment*2])rotate([0,90,0])cylinder(r=1.5, h=3, $fn=20);
    translate([2,49,12.5+center_adjustment*2])rotate([0,90,0])cylinder(r=1.5, h=3, $fn=20);

    // upper M3 screw end opening
    translate([2,41,11.5+center_adjustment*2])rotate([0,90,0])cylinder(r=1.5, h=3, $fn=20);
    translate([2,41,12+center_adjustment*2])rotate([0,90,0])cylinder(r=1.5, h=3, $fn=20);
    translate([2,41,12.5+center_adjustment*2])rotate([0,90,0])cylinder(r=1.5, h=3, $fn=20);

    // M3 nuts opening
    translate([0,46,9+center_adjustment*2]) m3nut();
    translate([0,38,9+center_adjustment*2]) m3nut();

    // flat bottom side
    translate([-20,33,-10]) cube([30,35,10]);

    // slot
    translate([-(6+center_adjustment),33,8+center_adjustment]) cube([1,25,10]);

    // Remove medial edge
//    translate([4,35]) cube([10,20,20]);

    // 45 / 30 deg edges

    translate([-20,57,13+center_adjustment]) rotate([45,0,0]) cube([25,3,15]);

    translate([0,45,-1]) rotate([0,30,0]) cube([15,15,15]);
    translate([7,46,-1]) rotate([0,0,30]) cube([15,11,25]);

    //PINDA mounting hole
    translate([-(5.5+center_adjustment),60,6+center_adjustment])rotate([90,0,0])cylinder(r=probe_width/2+0.1, h=30, $fn=20);
    translate([-(5.5+center_adjustment),41,6+center_adjustment])rotate([90,0,0])cylinder(r=probe_width/2+0.2, h=5, $fn=20);

    // bottom cut
    translate([-20,54.5,-1])  cube([30,20,30]);


    for ( i = [0 : 14] )
        {
          translate([-(5.5+center_adjustment),39+i,6+center_adjustment])rotate([90,0,0])cylinder(r1=probe_width/2+0.25, r2=probe_width/2-1, h=1, $fn=20);
          translate([-(5.5+center_adjustment),40+i,6+center_adjustment])rotate([90,0,0])cylinder(r1=probe_width/2-1, r2=probe_width/2+0.25, h=1, $fn=20);
        }

}

}

ex_body();
