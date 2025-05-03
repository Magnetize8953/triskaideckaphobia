// 0. Intro text explaining game

if (running_intro_text == 0) {
	layer_sprite_destroy(fourth_text);
	flip_pot();
	alarm[1] = 100;
} else {
	if (running_intro_text == 1100) {
		first_text = layer_sprite_create("Assets_1", room_width / 2, room_height / 2, spr_TutText1);
	} else if (running_intro_text == 825) {
		layer_sprite_destroy(first_text);
		second_text = layer_sprite_create("Assets_1", room_width / 2, room_height / 2, spr_TutText2);
	} else if (running_intro_text == 550) {
		layer_sprite_destroy(second_text);
		third_text = layer_sprite_create("Assets_1", room_width / 2, room_height / 2, spr_TutText3);
	} else if (running_intro_text == 275) {
		layer_sprite_destroy(third_text);
		fourth_text = layer_sprite_create("Assets_1", room_width / 2, room_height / 2, spr_TutText4);
	}
	running_intro_text--;
	alarm[0] = 1;
}