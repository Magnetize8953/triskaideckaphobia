// TODO: TEST FOR RESETTING HANDS, REMOVE 
if (keyboard_check_pressed(vk_space)) {
	alarm[0] = 5;
}

// TODO: TEST FOR INCREMENTING TURNS, REMOVE
if (keyboard_check_pressed(vk_backspace)) {
	next_turn();
}

// TODO: TEST FOR BASE RESETTING, REMOVE
if (keyboard_check(ord("B")) or (!global.base_card_exists and (global.base_picker == global.id_on_server))) {
	center_stack_reset();
	base_selecting();
}

// TODO: TEST FOR BUTTONS FOR HONEST/BLUFF, REMOVE
if (keyboard_check(ord("2")) or
    (global.base_card_exists and
    (global.current_turn == global.id_on_server) and
    !(instance_exists(obj_HonestButton) or instance_exists(obj_BluffButton) or instance_exists(obj_BluffNumberPrompter)
    or instance_exists(obj_PlayButton) or instance_exists(obj_CallBluff)))) {
	two_play_buttons();
}

// the only way to do this. gamemaker doesn't like polymorphism
if ((instance_exists(obj_HonestButton) or instance_exists(obj_BluffButton) or instance_exists(obj_BluffNumberPrompter) or
    instance_exists(obj_PlayButton) or instance_exists(obj_CallBluff)) and
    !global.base_card_exists) {
    if (instance_exists(obj_HonestButton)) { with (obj_HonestButton) { instance_destroy(self); } }
    if (instance_exists(obj_BluffButton)) { with (obj_BluffButton) { instance_destroy(self); } }
    if (instance_exists(obj_BluffNumberPrompter)) { with (obj_BluffNumberPrompter) { instance_destroy(self); } }
    if (instance_exists(obj_PlayButton)) { with (obj_PlayButton) { instance_destroy(self); } }
    if (instance_exists(obj_CallBluff)) { with (obj_CallBluff) { instance_destroy(self); } }
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
