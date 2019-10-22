wallWidth = 1.6;

innerWidth = 39;
innerLength = 82;
innerDepth = 10;

strapWidth = 22;
strapHeight = 2;

cushionLength = 2;

difference() {
    cube([2* wallWidth + innerWidth,  3 * wallWidth + cushionLength + innerLength, strapHeight + wallWidth + innerDepth]);
    translate([wallWidth, wallWidth, strapHeight + wallWidth]) cube([innerWidth, innerLength, innerDepth + 0.01]);
    translate([-0.01, innerLength/2 + wallWidth - strapWidth/2, -0.01]) cube([2 * wallWidth + 0.02 + innerWidth, strapWidth, strapHeight + 0.01]); 
    translate([wallWidth, innerLength + wallWidth + cushionLength, wallWidth]) cube([innerWidth, cushionLength, innerDepth]);
}
