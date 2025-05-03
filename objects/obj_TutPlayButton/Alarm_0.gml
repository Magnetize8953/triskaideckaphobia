// if cards are all flipped, move them to pile, otherwise don't
if (!ds_list_find_value(added_cards, ds_list_size(added_cards) - 1).flipping) {
	
	// moved staged stack to pile
	
	// hand off the procedure to recursive buttons that let the player craft their bluff
	instance_create_layer(0,0, "Instances", obj_BluffNumberPrompter, {num: get_rank(global.supposed_top), available: ds_list_size(added_cards), stag_size: staging_size, stag_reverse: staging_reversed, base_number: true, hand_message: ""});
	//instance_create_layer(room_width / 2 - (83 * 3), 1080 * (565/768), "Instances", obj_NumberButton, {num: 0});
	
	// Create the (for some reason) necessary object to destroy the play button
	instance_create_layer(0, 0, "Instances", obj_PlayDestroyer);
	// Make supposed_top the actual new top
	// TODO: ADD SCRIPT THAT RUNS PROMPT TO ASK PLAYER HOW MANY OF EACH THEY BLUFFED
} else {
	alarm[0] = 5;
}

	
	