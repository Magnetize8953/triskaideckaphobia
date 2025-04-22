// TODO: TEST FOR RESETTING HANDS, REMOVE 
if (keyboard_check_pressed(vk_space)) {
	alarm[0] = 5;
}

// TODO: TEST FOR INCREMENTING TURNS, REMOVE
if (keyboard_check_pressed(vk_backspace)) {
	next_turn();
}

// TODO: TEST FOR BASE RESETTING, REMOVE
if (keyboard_check(ord("B"))) {
	center_stack_reset();
	base_selecting();
}

// TODO: TEST FOR BUTTONS FOR HONEST/BLUFF, REMOVE
if (keyboard_check(ord("2"))) {
	two_play_buttons();
}