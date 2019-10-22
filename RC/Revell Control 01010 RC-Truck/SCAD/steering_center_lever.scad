leverHeight = 1.6;
leverWidth = 3;
leverLength = 14;

chassisThickness = 1.5;

interlockWidth = 10;
interlockLength = 2.5;
interlockDepth = 1;

columnDiameter = 7;
columnBottomHeight = leverHeight + chassisThickness + interlockDepth;

columnTopDiameter = 4;
columnTopHeight = 4;
columnTopWidth = 4;

heightSlack = 0.2;

wedgeAngle = 30;
wedgeAngleLowerLip = 15;

$fn = 64;

module lever() {    
    largeDia = columnDiameter - 1;
    smallDia = columnDiameter - 4;
    smallToLargeSpacing = leverLength - smallDia/2;
    hull() {
        cylinder(d = largeDia, leverHeight); 
        translate([0, smallToLargeSpacing, 0]) cylinder(d = smallDia, leverHeight);
    }
    translate([0, smallToLargeSpacing + 0.5, leverHeight]) sphere(d = 1);
}

module columnBottom() {
    cylinder(d = columnDiameter, h= columnBottomHeight + heightSlack);
    translate([0, 0 , leverHeight + chassisThickness + interlockDepth/2 + heightSlack]) cube([interlockWidth, interlockLength, interlockDepth], center = true);    
}

module columnTop() {
    difference() {
        cylinder(d = columnTopDiameter, h= columnTopHeight);
        rotate([0, 0, -wedgeAngle]) translate([columnTopWidth * 0.3, -columnTopDiameter, -0.01]) cube([columnTopDiameter, 2 * columnTopDiameter, columnTopHeight + 0.02]);
        rotate([0, 0, wedgeAngle]) translate([-columnTopDiameter - (columnTopWidth * 0.3), -columnTopDiameter, -0.01]) cube([columnTopDiameter, 2 * columnTopDiameter, columnTopHeight + 0.02]);
    }
}

module columnLowerLip() {
    difference() {
        cylinder(d = columnDiameter + 2.5, h = leverHeight);
        rotate([0, 0, wedgeAngleLowerLip]) translate([columnTopWidth/2, -columnDiameter, -0.01]) cube([columnDiameter, 2 * columnDiameter, columnTopHeight + 0.02]);
        rotate([0, 0, -wedgeAngleLowerLip]) translate([-columnDiameter - columnTopWidth/2, -columnDiameter, -0.01]) cube([columnDiameter, 2 * columnDiameter, columnTopHeight + 0.02]);
        translate([-columnDiameter/2, 0, -0.01]) cube([columnDiameter, columnDiameter, leverHeight + 0.02]);
    }
}


columnBottom();
lever();
translate([0, 0, columnBottomHeight + heightSlack]) columnTop();
columnLowerLip();
