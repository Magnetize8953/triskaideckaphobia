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

// TODO: TEST FOR FLIPPING POT, REMOVE
if (keyboard_check(ord("F"))) {
	flip_pot();
}

// make all cards faced up
if (keyboard_check(ord("G"))) {
    with (obj_Card) {
        if (face_down) {
            self.alarm[0] = 5;
        }
    }
}

// increase own points
if (keyboard_check(ord("P"))) {
    global.player1.points += 1;
}
