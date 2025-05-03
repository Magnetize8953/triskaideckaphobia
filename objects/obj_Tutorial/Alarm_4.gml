// 4.5 – message broadcast

if (post_4_text == 360) {
	seventeenth_text = layer_sprite_create("Assets_1", 570, room_height / 2, spr_TutText17);
	eighteenth_text = layer_sprite_create("Assets_1", room_width - 570, room_height / 2, spr_TutText18);
	post_4_text--;
	alarm[4] = 1;
} else if (post_4_text == 0) {
	layer_sprite_destroy(seventeenth_text);
	layer_sprite_destroy(eighteenth_text);
	global.hand_is_go = false;
	collected_cards = ds_stack_create();
	alarm[5] = 1;
} else {
	post_4_text--;
	alarm[4] = 1;
}