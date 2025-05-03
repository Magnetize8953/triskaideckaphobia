// 2.5 – message broadcast
if (post_2_text == 360) {
	seventh_text = layer_sprite_create("Assets_1", 570, room_height / 2, spr_TutText7);
	eighth_text = layer_sprite_create("Assets_1", room_width - 570, room_height / 2, spr_TutText8);
	post_2_text--;
	alarm[2] = 1;
} else if (post_2_text == 0) {
	layer_sprite_destroy(seventh_text);
	layer_sprite_destroy(eighth_text);
	global.hand_is_go = false;
	alarm[3] = 1;
} else {
	post_2_text--;
	alarm[2] = 1;
}