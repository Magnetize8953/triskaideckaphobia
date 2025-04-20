if (image_xscale < scale) {
    image_xscale += flip_scale;
    alarm[1] = flip_speed;
}

if (image_xscale >= scale) {
    image_xscale = scale;
    alarm[2] = 15;
}