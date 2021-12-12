template_width = 30;
template_height = 20;
template_thickness = 2;

connector_width = 18.8;
connector_height = 11.2;

f = 0.01;
df = 2*f;

difference() {
    cube([template_width, template_height, template_thickness]);
    translate([(template_width - connector_width)/2, (template_height - connector_height)/2, -f])
        cube([connector_width, connector_height, template_thickness + df]);
}