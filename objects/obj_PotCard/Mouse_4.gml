// TODO: Use this as a baseline for future loops through; need to reset 
// card_was_selected next time a card is going to be selected

/*
// Loop through other cards in the pot, check if there's one in the base
var other_base = false;
for (var i = 0; i = ds_list_size(global.pot_cards); i++) {
	show_debug_message("pot card inspected: " + string(i));
	if (ds_list_find_value(global.pot_cards, i).is_base) {
		other_base = true;
	}
}
*/
//if (!other_base and global.card_being_selected) {
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
	

}