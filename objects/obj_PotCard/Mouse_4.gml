// TODO: Use this as a baseline for future loops through; need to reset 
// card_was_selected next time a card is going to be selected
if (global.card_being_selected) {
	// No more card being selected
	global.card_being_selcted = false;
	
	// Card is the base of the pot
	self.is_base = true;
	
	// Remove card from the global pot
	ds_list_delete(global.pot, ds_list_find_index(global.pot, self.card_id));

	// A card was selected, play associated events
	global.card_was_selected = true;
	
	// Move to center of the room
	self.x = room_width / 2;
	self.y = room_height / 2;
	

}