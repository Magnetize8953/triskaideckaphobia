
with (obj_Tutorial) {
	if (other.num == 1) {
		layer_sprite_destroy(text_21);
		layer_sprite_destroy(text_22);
		alarm[7] = 1;
	} else {
		layer_sprite_destroy(text_23);
		layer_sprite_destroy(text_24);
		alarm[8] = 1;
	}
}

instance_destroy();