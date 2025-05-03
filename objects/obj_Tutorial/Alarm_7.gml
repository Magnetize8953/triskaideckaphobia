if (!twethre_twefou) {
	text_23 = layer_sprite_create("Assets_1", 570, room_height / 2, spr_TutText23);
	text_24 = layer_sprite_create("Assets_1", room_width - 570, room_height / 2, spr_TutText24);
	twethre_twefou = true;
	second_button = instance_create_layer(room_width / 2 - (83 * 2), 1080 * (565/768), "Instances", obj_TutNumberButton, {num: 2});
}