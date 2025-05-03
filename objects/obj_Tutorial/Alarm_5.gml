if (!nin_twe) {
	nineteenth_text = layer_sprite_create("Assets_1", 570, room_height / 2, spr_TutText19);
	twentieth_text = layer_sprite_create("Assets_1", room_width - 570, room_height / 2, spr_TutText20);
	first_arrow = instance_create_layer(3.5 * (_card_sprite_width), room_height - 290, "Instances", obj_PointerArrow);
	needA = true;
	second_arrow = instance_create_layer(8.5 * (_card_sprite_width), room_height - 290, "Instances", obj_PointerArrow);
	need9 = true;
	third_arrow = instance_create_layer(9.5 * (_card_sprite_width), room_height - 290, "Instances", obj_PointerArrow);
	need10 = true;
	nin_twe = true;
} 

if (ds_stack_size(collected_cards) == 3) {
	play_button = instance_create_layer(room_width / 2, 1080 * (565/768), "Instances", obj_TutPlayButton, {passed_cards: collected_cards, type: 1});
} else {
	alarm[5] = 1;
}