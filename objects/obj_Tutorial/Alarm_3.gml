if (!nine_ten) {
	ninth_text = layer_sprite_create("Assets_1", 570, room_height / 2, spr_TutText9);
	tenth_text = layer_sprite_create("Assets_1", room_width - 570, room_height / 2, spr_TutText10);
	
	arrow = instance_create_layer(1.5 * (_card_sprite_width), room_height - 290, "Instances", obj_PointerArrow);
	
	nine_ten = true; 
	need3 = true;
} else if (!eleven_twelve and arrow.x == 2.5 * (_card_sprite_width)) {
	eleventh_text = layer_sprite_create("Assets_1", 570, room_height / 2, spr_TutText11);
	twelth_text = layer_sprite_create("Assets_1", room_width - 570, room_height / 2, spr_TutText12);
	eleven_twelve = true;
} else if (!thir_four and arrow.x == 5.5 * (_card_sprite_width)) {
	layer_sprite_destroy(eleventh_text);
	layer_sprite_destroy(twelth_text);
	thirteenth_text = layer_sprite_create("Assets_1", 570, room_height / 2, spr_TutText13);
	fourteenth_text = layer_sprite_create("Assets_1", room_width - 570, room_height / 2, spr_TutText14);
	thir_four = true;
} else if (!fif_six and arrow.x == 11.5 * (_card_sprite_width)) {
	layer_sprite_destroy(thirteenth_text);
	layer_sprite_destroy(fourteenth_text);
	fifteenth_text = layer_sprite_create("Assets_1", 570, room_height / 2, spr_TutText15);
	sixteenth_text = layer_sprite_create("Assets_1", room_width - 570, room_height / 2, spr_TutText16);
	fif_six = true;
}

if (arrow.x == 2.5 * (_card_sprite_width)) {
	layer_sprite_destroy(ninth_text);
	layer_sprite_destroy(tenth_text);
	need4_1 = true;

	alarm[3] = 1;
} else if (arrow.x == 5.5 * (_card_sprite_width)) {
	layer_sprite_destroy(eleventh_text);
	layer_sprite_destroy(twelth_text);
	need4_2 = true;
	alarm[3] = 1;
} else if (arrow.x == 11.5 * (_card_sprite_width)) {
	layer_sprite_destroy(thirteenth_text);
	layer_sprite_destroy(fourteenth_text);
	need5 = true;
	alarm[3] = 1;
}

else {
	alarm[3] = 1;
}