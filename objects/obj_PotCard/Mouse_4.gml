// TODO: Use this as a baseline for future loops through; need to reset 
// card_was_selected next time a card is going to be selected

// If there is no base card, and a base card is being selected
if (!global.base_card and global.card_being_selected) {
	// No more card being selected
	global.card_being_selcted = false;
	global.base_card = true;
	
	// Card is the base of the pot
	self.is_base = true;
	
	// Remove card from the global pot
	ds_list_delete(global.pot, ds_list_find_index(global.pot, self.card_id));
	
	// Move to center of the room
	self.x = room_width / 2;
	self.y = room_height / 2;
	
	image_xscale = global.stack_scale;
	image_yscale = global.stack_scale;
	
    ds_stack_push(global.pile, self);

}