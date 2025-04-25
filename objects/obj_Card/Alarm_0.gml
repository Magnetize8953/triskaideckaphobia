if (image_xscale != 0) {
    image_xscale -= flip_scale;
    alarm[0] = flip_speed;
} else {
    if (face_down) {
	    image_index = 0;
	} else {
	    image_index = card_id;
	}
    
    face_down = !face_down;
    alarm[1] = flip_speed;
}

if (image_xscale <= 0) {
    image_xscale = 0;
    alarm[2] = 15;
}