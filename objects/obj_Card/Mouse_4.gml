/*
if (!flipping) {
    alarm[0] = flip_speed;
    flipping = true;
}
*/

// If an honest hand is being built and it's my turn (and also im not in the center)
if (global.building_honest_hand and global.current_turn == self.associated_player.num and self.x != room_width / 2 and self.y != room_height / 2) {
	// If there is no cards currently being queued, and the selected one can be played on the top of the stack
	if (ds_stack_size(global.staging_cards) == 0 and validate_stack(self.card_id, ds_stack_top(global.pile).card_id)) {
		ds_stack_push(global.staging_cards, self);
		self.y -= 15; // TODO: MAKE SIGNIFYING SELECTED CARDS BETTER
	// If this next selected card is a valid play
	} else if (ds_stack_size(global.staging_cards) != 0 and validate_stack(self.card_id, ds_stack_top(global.staging_cards).card_id)) {
		ds_stack_push(global.staging_cards, self);
		self.y -= 15; // TODO: MAKE SIGNIFYING SELECTED CARDS BETTER
	} else if (ds_stack_top(global.staging_cards) == self) {
		ds_stack_pop(global.staging_cards);
		self.y += 15;
	}
}