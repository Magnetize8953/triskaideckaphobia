// TODO: uncomment out and finish 
// play_hand script call here
// If there are cards set to be played
if (ds_stack_size(global.staging_cards) > 0 and !global.hand_is_go and global.building_honest_hand) {
	// Disable it happening a second time, to start
	global.hand_is_go = true;
	
	// make self invisible
	self.image_alpha = 0;
	
	// Turn off the honest hand tracking, because we don't need that anymore
	global.building_honest_hand = false;
	
	show_debug_message("Current stack size: " + string(ds_stack_size(global.staging_cards)));
	show_debug_message("Top of stack: " + string(ds_stack_top(global.staging_cards)));
	
    
    // reverse stack
    staging_reversed = ds_stack_create();
    staging_size = ds_stack_size(global.staging_cards);
    for (var i = 0; i < staging_size; i++) {
        ds_stack_push(staging_reversed, ds_stack_pop(global.staging_cards));
    }
    
    // moved staged stack to pile
    for (var i = 0; i < staging_size; i++) {
        var next_card = ds_stack_pop(staging_reversed);
        next_card.x = room_width / 2;
        next_card.y = room_height / 2;
        next_card.image_xscale = global.stack_scale;
        next_card.image_yscale = global.stack_scale;
        randomize();
        next_card.image_angle = random_range(0, 180);
        next_card.depth = -1 + -ds_stack_size(global.pile);
		show_debug_message("next card depth: " + string(next_card.depth));
		
        ds_stack_push(global.pile, next_card);
    }
	
	// Make supposed_top the actual new top
	global.supposed_top = ds_stack_top(global.pile).card_id;
	
	
}
else if (ds_stack_size(global.staging_cards) > 0 and !global.hand_is_go and global.building_bluffed_hand){
	// Disable it happening a second time, to start
	global.hand_is_go = true;
	
	// make self invisible
	self.image_alpha = 0;
	
	// Turn off the honest hand tracking, because we don't need that anymore
	global.building_bluffed_hand = false;
	
	show_debug_message("Current stack size: " + string(ds_stack_size(global.staging_cards)));
	show_debug_message("Top of stack: " + string(ds_stack_top(global.staging_cards)));
	
    
    // reverse stack
    staging_reversed = ds_stack_create();
    staging_size = ds_stack_size(global.staging_cards);
    for (var i = 0; i < staging_size; i++) {
        ds_stack_push(staging_reversed, ds_stack_pop(global.staging_cards));
    }
    
	
	for (var i = 0; i < staging_size; i++) {
		// If the card isn't flipping yet, start it flipping
		if (!ds_list_find_value(added_cards, i).flipping) {
			ds_list_find_value(added_cards, i).flipping = true;
			ds_list_find_value(added_cards, i).alarm[0] = 5;
		}
	}
	// Go to alarm to wait for cards to flip
	alarm[0] = 5;
	
} 

if (global.hand_is_go and type == 1) {
	instance_destroy();
}