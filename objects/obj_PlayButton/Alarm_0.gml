// if cards are all flipped, move them to pile, otherwise don't
if (!ds_list_find_value(added_cards, ds_list_size(added_cards) - 1).flipping) {
	
	// moved staged stack to pile
	/*
    for (var i = 0; i < staging_size; i++) {
        var next_card = ds_stack_pop(staging_reversed);
        next_card.x = room_width / 2;
        next_card.y = room_height / 2;
        next_card.image_xscale = global.stack_scale;
        next_card.image_yscale = global.stack_scale;
        randomize();
        next_card.image_angle = random_range(0, 180);
        next_card.depth = -1 + -ds_stack_size(global.pile);
		
		ds_list_add(global.last_played_hand, next_card); // add to global last hand tracker
		global.which_last_hand = "bluff";
		
        ds_stack_push(global.pile, next_card);
    }
	*/
	
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

	
	