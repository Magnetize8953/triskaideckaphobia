// TODO: TEST FOR RESETTING HANDS, REMOVE 
if (keyboard_check_pressed(vk_space) and !safe_guard) {
	safe_guard = true;
	alarm[0] = 5;
}