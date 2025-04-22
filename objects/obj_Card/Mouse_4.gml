/*
if (!flipping) {
    alarm[0] = flip_speed;
    flipping = true;
}
*/

var in_pot = instance_position(room_width / 2, room_height / 2, obj_Card);

// If an honest hand is being built and it's my turn
if (global.building_honest_hand and global.current_turn == self.associated_player.num) {
	// If there is no cards currently being queued, and the selected one can be played on the top of the stack
	if (ds_stack_size(global.staging_cards) == 0 and validate_stack(self.card_id, in_pot.card_id)) {
		ds_stack_push(global.staging_cards, self);
		self.y -= 15; // TODO: MAKE SIGNIFYING SELECTED CARDS BETTER
	// If this next selected card is a valid play
	} else if (validate_stack(self.card_id, ds_stack_top(global.staging_cards).card_id)) {
		ds_stack_push(global.staging_cards, self);
		self.y -= 15; // TODO: MAKE SIGNIFYING SELECTED CARDS BETTER
	} else if (ds_stack_top(global.staging_cards) == self) {
		ds_stack_pop(global.staging_cards);
		self.y += 15;
	}
} 
/*
else if (in_pot != noone) { // If one exists
	if (validate_stack(self.card_id, in_pot.card_id) and (global.current_turn == self.associated_player.num)) { // if clicked on card is a valid play and its your turn
		instance_destroy(in_pot);
		self.x = room_width / 2;
		self.y = room_height / 2;
		image_xscale = global.stack_scale;
		image_yscale = global.stack_scale;
		image_angle = 0;
	}
}
*/