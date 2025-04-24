/*
if (!flipping) {
    alarm[0] = flip_speed;
    flipping = true;
}
*/


show_debug_message("rank: " + string(get_rank(self.card_id)));
show_debug_message("card id itself: " + string(self.card_id));


// If an honest hand is being built and it's my turn (and also im not in the center)
if (global.building_honest_hand and global.current_turn == self.associated_player.num and !(self.x == room_width / 2 and self.y == room_height / 2)) {
	// If there is no cards currently being queued, and the selected one can be played on the top of the stack
	if (ds_stack_size(global.staging_cards) == 0 and validate_stack(self.card_id, global.supposed_top)) {
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

else if (global.building_bluffed_hand and global.current_turn == self.associated_player.num and !(self.x == room_width / 2 and self.y == room_height / 2)) {
	var button = instance_nearest(self.x, self.y, obj_PlayButton);
	// If i am the most recently staged card, deselect me
	if (ds_stack_top(global.staging_cards) == self) {
		ds_stack_pop(global.staging_cards);
		self.y += 15;
		// Delete from the button's log of cards
		ds_list_delete(button.added_cards, ds_list_find_index(button.added_cards , self));
	// otherwise, select me if I'm not already selected
	} else if (ds_list_find_index(button.added_cards, self) == -1){
		
		ds_stack_push(global.staging_cards, self);
		ds_list_add(button.added_cards, self);
		self.y -= 15;
	} 
} else { show_debug_message("That shouldn't have happened")}