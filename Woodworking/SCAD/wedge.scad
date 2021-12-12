wedge_width = 40;
wedge_length = 25;

wegde_height1 = 10;
wedge_height2 = 13;

hull() {
    cube([wedge_width, wedge_length, wegde_height1]);
    cube([wedge_width, 0.01, wedge_height2]);
}
