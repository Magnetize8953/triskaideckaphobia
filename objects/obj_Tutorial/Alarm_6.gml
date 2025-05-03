if (!tweone_twetwo) {
	text_21 = layer_sprite_create("Assets_1", 570, room_height / 2, spr_TutText21);
	text_22 = layer_sprite_create("Assets_1", room_width - 570, room_height / 2, spr_TutText22);
	tweone_twetwo = true;
	first_button = instance_create_layer(room_width / 2 - (83 * 2), 1080 * (565/768), "Instances", obj_TutNumberButton, {num: 1});
}